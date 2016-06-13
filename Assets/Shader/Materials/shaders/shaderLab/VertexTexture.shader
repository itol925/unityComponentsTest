Shader "Custom/VertexTexture" {
	Properties {
		_Color("diffuse color", COLOR) = (1, 0, 0, 1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Shininess("shininess", Range(0.01, 1)) = 0.7
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color] 
				Ambient [_Color]
				Shininess[_Shininess]
				Specular(1,1,1,1)
				Emission(0,0,0,0)
			}
			Lighting On
			Cull Front	// 只渲染背面，见正方体方块
			
			SetTexture[_MainTex]{}	// 必须放在通道的末尾
			//语法： SetTexture[TexturePropertyName]{Texture Block}
			// texture block定义了如何处理纹理 
		}
	} 
	FallBack "Diffuse"
}
