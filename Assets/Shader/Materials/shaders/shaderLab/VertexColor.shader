Shader "Custom/VertexColor" {
	SubShader {
		Pass{
			Material {
				Diffuse(1, 0, 0, 1)	// 漫反射
				Ambient(1, 1, 1, 1)	// 环境光
			}
			Lighting On
		}
	}
}
