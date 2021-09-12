using System;
using UnityEngine;

namespace UnityEditor
{
	internal class FBMParalaxCloudsGUI : ShaderGUI
	{
		private const string RaymarchingKeyWord = "RAYMARCHING";

		private MaterialProperty _baseColor;
		private MaterialProperty _colorRamp;
		private MaterialProperty _scale;

		private MaterialProperty _height;
		private MaterialProperty _fadeHeight;
		private MaterialProperty _fadeSmooth;

		private MaterialProperty _cloudsSpeed;
		private MaterialProperty _clipFade;
		private MaterialProperty _clipFactor;

		private class Styles
		{
			public static GUIContent ColorRamp = new GUIContent("Color Ramp", "Color over height");
		}

		private void FindProperties(MaterialProperty[] props)
		{
			_baseColor = FindProperty("_BaseColor", props);
			_colorRamp = FindProperty("_ColorRamp", props);
			_scale = FindProperty("_Scale", props);
			_height = FindProperty("_Height", props);

			_fadeHeight = FindProperty("_FadeHeight", props);
			_fadeSmooth = FindProperty("_FadeSmooth", props);
			_cloudsSpeed = FindProperty("_CloudsSpeed", props);

			_clipFade = FindProperty("_ClipFade", props);
			_clipFactor = FindProperty("_ClipFactor", props);
		}

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			//base.OnGUI(materialEditor, properties);
			Material material = materialEditor.target as Material;
			FindProperties(properties);

			materialEditor.TexturePropertySingleLine(Styles.ColorRamp, _colorRamp, _baseColor);
			EditorGUI.BeginChangeCheck();
			var offsetAndScale = EditorGUILayout.Vector2Field("Offset and Scale",
				new Vector2(_colorRamp.textureScaleAndOffset.z, _colorRamp.textureScaleAndOffset.x));
			if (EditorGUI.EndChangeCheck())
				_colorRamp.textureScaleAndOffset = new Vector4(offsetAndScale.y, 0, offsetAndScale.x);

			EditorGUILayout.Separator();
			RaymarchingField(material);
			EditorGUILayout.Separator();
			materialEditor.DefaultShaderProperty(_scale, "Clouds Scale");
			materialEditor.DefaultShaderProperty(_cloudsSpeed, "Noise Speed");
			EditorGUILayout.Separator();
			materialEditor.DefaultShaderProperty(_height, "Height");
			materialEditor.DefaultShaderProperty(_fadeHeight, "Height Fade");
			materialEditor.DefaultShaderProperty(_fadeSmooth, "Fade Smooth");
			EditorGUILayout.Separator();
			materialEditor.DefaultShaderProperty(_clipFade, "Clip Fade");
			materialEditor.DefaultShaderProperty(_clipFactor, "Clip Factor");

			materialEditor.RenderQueueField();
		}

		private static void RaymarchingField(Material material)
		{
			EditorGUI.BeginChangeCheck();
			var raymaching = Array.IndexOf(material.shaderKeywords, RaymarchingKeyWord) != -1;
			raymaching = EditorGUILayout.Toggle("Use Raymarching", raymaching);
			if (EditorGUI.EndChangeCheck())
			{
				if (raymaching)
					material.EnableKeyword(RaymarchingKeyWord);
				else
					material.DisableKeyword(RaymarchingKeyWord);
			}
		}
	}
}
