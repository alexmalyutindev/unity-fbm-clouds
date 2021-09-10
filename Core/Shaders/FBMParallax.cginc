#include "FBM.cginc"
 #pragma shader_feature RAYMARCHING

float _ParallaxStrength;
float _CloudTime;

inline float CloudNoise(float2 uv)
{
    const float2 q = float2(fbm(uv + _CloudTime * .01), fbm(uv) + 1.);

    const float2 r = float2(
        fbm(uv + 1.0 * q + float2(1.7, 9.2) + 0.15 * _CloudTime),
        fbm(uv + 1.0 * q + float2(8.3, 2.8) + 0.126 * _CloudTime)
    );

    return fbm(uv + r);
}

// Simple paralax offset
inline float2 ParallaxOffset(float2 uv, float2 viewDir)
{
    float height = CloudNoise(uv);
    height -= 0.42;
    height *= _ParallaxStrength;
    return viewDir * height;
}

// Raymarched paralax offset
#if RAYMARCHING
#define PARALLAX_FUNCTION ParallaxRaymarching
#endif
inline float2 ParallaxRaymarching(float2 uv, float2 viewDir)
{
    float2 uvOffset = 0;
    float stepSize = 0.1;
    float2 uvDelta = viewDir * (stepSize * _ParallaxStrength);

    float stepHeight = 1;
    float surfaceHeight = CloudNoise(uv);

    float2 prevUVOffset = uvOffset;
    float prevStepHeight = stepHeight;
    float prevSurfaceHeight = surfaceHeight;

    for (int i = 1; i < 10 && stepHeight > surfaceHeight; i++)
    {
        prevUVOffset = uvOffset;
        prevStepHeight = stepHeight;
        prevSurfaceHeight = surfaceHeight;

        uvOffset -= uvDelta;
        stepHeight -= stepSize;
        surfaceHeight = CloudNoise(uv + uvOffset);
    }

    const float prevDifference = prevStepHeight - prevSurfaceHeight;
    const float difference = surfaceHeight - stepHeight;
    const float t = prevDifference / (prevDifference + difference);
    uvOffset = prevUVOffset - uvDelta * t;

    return uvOffset;
}


// Just a cloud height
inline float CloudNoise(float2 uv, float time)
{
    _CloudTime = time;
    return CloudNoise(uv);
}

// Parallaxed cloud height
// viewDir - in tangent space
inline float ParallaxCloudHeight(float3 tangentViewDir, float parallaxStrength, float2 uv, float time)
{
    _CloudTime = time;
    _ParallaxStrength = -parallaxStrength;

    tangentViewDir = normalize(tangentViewDir);
    tangentViewDir.xy = tangentViewDir.xy / (tangentViewDir.z + 0.42);

    #if !defined(PARALLAX_FUNCTION)
    #define PARALLAX_FUNCTION ParallaxOffset
    #endif

    float2 uvOffset = PARALLAX_FUNCTION(uv, tangentViewDir);
    uv.xy += uvOffset;

    return CloudNoise(uv);
}

// Parallaxed cloud height with deformed UV
// viewDir - in tangent space
inline float ParallaxCloudHeight(float3 tangentViewDir, float parallaxStrength, float2 uv, float time, out float2 deformedUV)
{
    _CloudTime = time;
    _ParallaxStrength = -parallaxStrength;

    tangentViewDir = normalize(tangentViewDir);
    tangentViewDir.xy = tangentViewDir.xy / (tangentViewDir.z + 0.42);

    #if !defined(PARALLAX_FUNCTION)
    #define PARALLAX_FUNCTION ParallaxOffset
    #endif

    float2 uvOffset = PARALLAX_FUNCTION(uv, tangentViewDir);
    uv.xy += uvOffset;

	deformedUV = uv.xy;
    return CloudNoise(uv);
}
