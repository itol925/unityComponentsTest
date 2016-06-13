Shader "Custom/textureDiffuse" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert
			struct Input {
				float2 uv_MainTex;	// 这是一个纹理坐标(u. v)
			};
			sampler2D _MainTex;
			void surf (Input IN, inout SurfaceOutput o) {
				half4 c = tex2D (_MainTex, IN.uv_MainTex);//返回纹理_MainTex在IN.uv_MainTex位置的颜色。
				o.Albedo = c.rgb;
			}
		ENDCG
	} 
	FallBack "Diffuse"
}
