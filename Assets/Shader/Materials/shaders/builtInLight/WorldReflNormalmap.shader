//受法线贴图 (normal map) 影响的反射
Shader "Custom/WorldReflNormalmap" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump"{}
		_Cube ("Cubemap", CUBE) = ""{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 worldRefl;
			INTERNAL_DATA	// 注，没有';'
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			float3 wv = WorldReflectionVector(IN, o.Normal);
			o.Emission = texCUBE(_Cube, wv).rgb;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
