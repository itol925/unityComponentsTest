Shader "Custom/FinalColorModifierFog" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_FogColor ("Fog color", Color) = (0.3, 0.1, 0.1, 1.0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert finalcolor:mycolor vertex:vert

		sampler2D _MainTex;
		fixed4 _FogColor;

		struct Input {
			float2 uv_MainTex;
			half fog;
		};
		
		void vert(inout appdata_full v, out Input data){
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float4 hpos = mul(UNITY_MATRIX_MVP, v.vertex);	// 矩阵相乘
			data.fog = min(1, dot(hpos.xy, hpos.xy) * 0.1);
		}
		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color){
			fixed3 fogColor = _FogColor.rgb;
			#ifdef UNITY_PASS_FORWARDADD
			fogColor = 0;
			#endif
			color.rgb = lerp(color.rgb, fogColor, IN.fog);// lerp(x, y, s). 对x、y进行插值计算。Returns x + s(y - x)
		}
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
