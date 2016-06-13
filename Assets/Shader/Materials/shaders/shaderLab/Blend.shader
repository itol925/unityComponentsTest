Shader "Custom/Blend" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass{
			//Blend One One	// 目标和源想加，即结果=(Rs+Rd, Gs+Gd, Bs+Bd)
			//Blend One Zero
			//Blend Zero One
			Blend DstColor Zero
			
			SetTexture[_MainTex]{
				combine texture
			}
		}
	}
}
