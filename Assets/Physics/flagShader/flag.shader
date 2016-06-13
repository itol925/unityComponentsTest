Shader "flag" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass{
			Cull Off
			
			SetTexture[_MainTex]{
				combine texture
			}
		}
		
	}
	FallBack "Diffuse"
}
