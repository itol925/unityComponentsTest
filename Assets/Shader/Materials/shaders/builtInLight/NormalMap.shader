//法线贴图
//应用到3D表面的特殊纹理，不同于以往的纹理只可以用于2D表面，作为凹凸纹理的扩展，
//它使得每个像素拥有高度值，包含了许多细节的表面信息，能够记纹理产生立体效果。

Shader "Custom/NormalMapDiffuse" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 c2 = tex2D(_BumpMap, IN.uv_BumpMap);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(c2);
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
