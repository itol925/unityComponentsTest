Shader "Custom/simpleDiffuse" {
	SubShader {
		Tags{ "RenderType" = "Opaque"}
		CGPROGRAM
			#pragma surface surf Lambert
			struct Input{
				float4 color : COLOR;
			};
			void surf(Input IN, inout SurfaceOutput o){
				o.Albedo = 2.0;	// 加强了反射率
			}
		ENDCG
	}
	FallBack "Diffuse"
}
