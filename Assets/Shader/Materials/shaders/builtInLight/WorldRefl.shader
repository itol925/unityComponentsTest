// 输入进行立方体贴图反射的着色器
Shader "Custom/WorldRefl" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cube ("Cubemap", CUBE) = ""{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * 0.5;
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
