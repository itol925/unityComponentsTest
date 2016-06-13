// 边缘光照，以高亮显示对象的边缘，即基于表面法线与视线的角度添加一些发射光。
Shader "Custom/Rim" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
		_RimColor ("Rim Color", Color) = (0.26, .019, 0.16, 0.0)
		_RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 c2 = tex2D(_BumpMap, IN.uv_BumpMap);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(c2);
			
			float3 nv = normalize(IN.viewDir);
			float dv = dot(nv, o.Normal);	//取点积，<0说明夹角大于90度；=0表示垂直；>0表示为锐角。
			float rim = saturate(dv);		//saturate会将值限定在[0,1],小于0则取0，大于1则取1
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
