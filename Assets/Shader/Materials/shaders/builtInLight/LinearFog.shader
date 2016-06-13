﻿Shader "Custom/LinearFog" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert finalcolor:mycolor vertex:vert
		
		sampler2D _MainTex;
		uniform half4 unity_FogColor;
		uniform half4 unity_FogStart;
		uniform half4 unity_FogEnd;

		struct Input {
			float2 uv_MainTex;
			half fog;
		};
		
		void mycolor(Input IN, SurfaceOutput o, inout fixed4 color){
			fixed3 fogColor = unity_FogColor.rgb;
			#ifdef UNITY_PASS_FORWARDADD
			fogColor = 0;
			#endif
			color.rgb = lerp (fogColor, color.rgb, IN.fog);
		}
		void vert(inout appdata_full v, out Input data){
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float pos = length(mul (UNITY_MATRIX_MV, v.vertex).xyz);
			float diff = unity_FogEnd.x - unity_FogStart.x;
			float invDiff = 1.0f / diff;
			data.fog = clamp ((unity_FogEnd.x - pos) * invDiff, 0.0, 1.0);
		}
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
		} 
		ENDCG
	} 
	FallBack "Diffuse"
}
