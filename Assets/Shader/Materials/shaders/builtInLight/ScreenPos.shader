// 屏幕空间中的细节纹理
Shader "Custom/ScreenPos" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Detail("Detail", 2D) = "gray" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Detail;

		struct Input {
			float2 uv_MainTex;
			float4 screenPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			
			float2 screenUV = IN.screenPos.xy / IN.screenPos.w;
			screenUV *= float2(8, 6);
			o.Albedo *= tex2D(_Detail, screenUV).rgb * 2;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
