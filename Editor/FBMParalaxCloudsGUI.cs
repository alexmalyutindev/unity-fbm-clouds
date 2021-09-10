using System;
using UnityEditor;
using UnityEngine;

namespace UnityEditor
{
    internal class FBMParalaxCloudsGUI : ShaderGUI
    {
        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            base.OnGUI(materialEditor, properties);
            Material targetMat = materialEditor.target as Material;

            bool raymaching = Array.IndexOf(targetMat.shaderKeywords, "RAYMARCHING") != -1;

            raymaching = EditorGUILayout.Toggle("Raymaching", raymaching);
            if (EditorGUI.EndChangeCheck())
            {
                if (raymaching)
                    targetMat.EnableKeyword("RAYMARCHING");
                else
                    targetMat.DisableKeyword("RAYMARCHING");
            }
        }
    }
}