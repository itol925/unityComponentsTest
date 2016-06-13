// 切片
Shader "Custom/Slices" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Cull off
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float testValue = frac((IN.worldPos.x + IN.worldPos.z*0.1) * 5);//frac(v)返回v的小数部分
			clip(testValue - 0.5); //如果testValue - 0.5小于0，则丢弃当前像素
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
