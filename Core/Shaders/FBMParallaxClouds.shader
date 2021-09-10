Shader "Clouds/FBMParallaxClouds"
{
	Properties
	{
		[MainTexture] _MainTex ("Texture", 2D) = "white" {}
		_Gradient ("Gradient", 2D) = "white" {}
		_Height ("Height", Range(0.0, 5.0)) = 1.0
		_Scale ("Scale", Float) = 2

		_CloudsSpeed ("Clouds speed", Float) = 25.0

		_FadeHeight ("Fade Height", Range(0.0, 1.0)) = 0.0
		_FadeSmooth ("Fade Smooth", Range(0.0, 1.0)) = 0.0

		_ClipFade ("Clip fade", Range(0.001, 5.0)) = 0.77
		_ClipFactor ("Clip factor", Range(0.0, 5.0)) = 0.74
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha //, One OneMinusSrcAlpha
		ZTest LEqual
		ZWrite Off

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile_fog

			//#define RAYMARCHING
			#include "UnityCG.cginc"
			#include "FBMParallax.cginc"

			struct appdata
			{
				float4 positionOS : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float3 positionWS : TEXCOORD0;
				float3 viewDirTS : TEXCOORD1;
				float4 grabPos : TEXCOORD2;
				UNITY_FOG_COORDS(3)
				float4 positionCS : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _Gradient;
			float4 _Gradient_ST;

			float _Height;
			float _Scale;
			float _FadeHeight;
			float _FadeSmooth;

			v2f vert (appdata v)
			{
				v2f o;
				o.positionCS = UnityObjectToClipPos(v.positionOS);
				o.positionWS = mul(unity_ObjectToWorld, v.positionOS) / _Scale; // Worldspace UV

				TANGENT_SPACE_ROTATION;
				float3 viewDirWS = WorldSpaceViewDir(v.positionOS);
				o.viewDirTS = mul(rotation, viewDirWS); 

				o.grabPos = ComputeGrabScreenPos(o.positionCS);

				UNITY_TRANSFER_FOG(o,o.positionCS);
				return o;
			}

			sampler2D _CameraDepthTexture;
			float _ClipFactor;
			float _ClipFade;
			float _CloudsSpeed;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 uv;
				float parallaxedHeight = ParallaxCloudHeight(i.viewDirTS, _Height, i.positionWS.xz, _Time.x * _CloudsSpeed, uv);
				float height = 1 - CloudNoise(i.positionWS.xz, _Time.x * _CloudsSpeed);

				float depth = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, i.grabPos).x);
				float depthDiff = depth - LinearEyeDepth(i.positionCS.z);

				float clipBlend = saturate((depthDiff - height * _ClipFactor) / _ClipFade);

				float2 gUV = parallaxedHeight.xx;
				fixed4 col = tex2D(_Gradient, TRANSFORM_TEX(gUV, _Gradient));
				col *= tex2D(_MainTex, uv);
				
				col.a = smoothstep(_FadeHeight, _FadeHeight + _FadeSmooth, parallaxedHeight) * clipBlend;

				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
	CustomEditor "FBMParalaxCloudsGUI"
}
