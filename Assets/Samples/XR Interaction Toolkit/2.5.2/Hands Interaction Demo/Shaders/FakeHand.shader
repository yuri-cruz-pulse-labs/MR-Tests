Shader "Custom/FakeHand"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        
        
        _MainColor("Main Color", Color) = (0, 0, 0, 0.6588235)
        _EdgeColor("Edge Color", Color) = (1, 1, 1, 0.8)
        _EdgeHighlightPower("Edge Highlight Power", Float) = 5
        [NoScaleOffset]_CombinedFingerIndexHighlightMask("Combined Finger Index Highlight Mask", 2D) = "white" {}
        _ThumbColor("Thumb Color", Color) = (1, 1, 1, 0.5019608)
        _FingerColor_1("Finger Color (1)", Color) = (1, 1, 1, 0.5019608)
        _FingerColor_2("Finger Color (2)", Color) = (1, 1, 1, 0.5019608)
        _FingerColor_3("Finger Color (3)", Color) = (1, 1, 1, 0.5019608)
        _FingerColor_4("Finger Color (4)", Color) = (1, 1, 1, 0.5019608)
        _FadeCenter("Fade Center", Vector) = (0, 0, 0.15, 0)
        _FadeScale("Fade Scale", Vector) = (1, 4, 1, 0)
        _FadeSize("Fade Size", Float) = 0.02
        _FadeStart("Fade Start", Float) = 0.12
        [HideInInspector]_BUILTIN_Surface("Float", Float) = 1
        [HideInInspector]_BUILTIN_Blend("Float", Float) = 0
        [HideInInspector]_BUILTIN_AlphaClip("Float", Float) = 0
        [HideInInspector]_BUILTIN_SrcBlend("Float", Float) = 1
        [HideInInspector]_BUILTIN_DstBlend("Float", Float) = 0
        [HideInInspector]_BUILTIN_ZWrite("Float", Float) = 0
        [HideInInspector]_BUILTIN_ZWriteControl("Float", Float) = 0
        [HideInInspector]_BUILTIN_ZTest("Float", Float) = 4
        [HideInInspector]_BUILTIN_CullMode("Float", Float) = 2
        [HideInInspector]_BUILTIN_QueueOffset("Float", Float) = 0
        [HideInInspector]_BUILTIN_QueueControl("Float", Float) = -1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _MainColor;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainColor;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
