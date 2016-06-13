// 使用顶点修改器函数，该函数将修改顶点着色器中的输入顶点数据，可用于程序性动画、沿法线的挤压等
Shader "Custom/vertexModifier" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Amount ("Extusion Amount", Range(-1, 1)) = 0.3
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		sampler2D _MainTex;
		float _Amount;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		void vert(inout appdata_full v){
			v.vertex.xyz += v.normal * _Amount;	// 沿法线方向	
		}
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
