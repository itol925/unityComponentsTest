Shader "Custom/simpleDiffuseCL" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf MyLambert
		// atten(attenuation)表示光衰减
		half4 LightingMyLambert(SurfaceOutput s, half3 lightDir, half atten){
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			// 方法一：普通
			//c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 2);
			
			// 方法二：照明“环绕”在对象边缘。它对模拟子面散射效果有用
			half diff = NdotL * 0.5 + 0.5;
			c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
			c.a = s.Alpha;
			return c;
		}

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
