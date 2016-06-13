// 做双层纹理
Shader "Custom/DetailTexture" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		//_BumpMap("Bumpmap", 2D) = "bump"{}
		_Detail("Detail", 2D) = "gray"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Detail;
		//sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
			//float2 uv_BumpMap;
			float2 uv_Detail;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 c2 = tex2D(_Detail, IN.uv_Detail);
			//half4 c3 = tex2D(_BumpMap, IN.uv_BumpMap);
			o.Albedo = c.rgb * c2.rgb * 2;// 为什么是乘？
			//o.Normal = UnpackNormal (c3);
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
