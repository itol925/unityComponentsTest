Shader "Custom/AlphaTest" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			// Greater大于； GEqual大于或等于； Less小于； LEqual小于或等于
			// NotEqual不等于； Always总是 Never不渲染任何
			AlphaTest Greater 0.14		// 只渲染alpha 大于14% 的像素
			SetTexture[_MainTex]{
				combine texture
			}
		}
	} 
	FallBack "Diffuse"
}
