// Properties的格式及说明：
// 格式： 
// _Name("Display Name", type) = defaultValue[{options}]
//
// 参数说明：
// _Name 		- 属性的名字，简单说就是变量名，在之后整个Shader代码中将使用这个名字来获取该属性的内容
// Display Name - 这个字符串将显示在Unity的材质编辑器中作为Shader的使用者可读的内容
// type 		- 这个属性的类型，可能的type所表示的内容有以下几种：
// 		Color 	- 一种颜色，由RGBA（红绿蓝和透明度）四个量来定义；
// 		2D 		- 一张2的阶数大小（256，512之类）的贴图。这张贴图将在采样后被转为对应基于模型UV的每个
//				  像素的颜色，最终被显示出来；
// 		Rect 	- 一个非2阶数大小的贴图；
// 		Cube 	- 即Cube map texture（立方体纹理），简单说就是6张有联系的2D贴图的组合，主要用来做
//				  反射效果（比如天空盒和动态反射），也会被转换为对应点的采样；
// 		Range(min, max) - 一个介于最小值和最大值之间的浮点数，一般用来当作调整Shader某些特性的
//				  参数（比如透明度渲染的截止值可以是从0至1的值等）；
// 		Float 	- 任意一个浮点数；
// 		Vector 	- 一个四维数；
// defaultValue 定义了这个属性的默认值，通过输入一个符合格式的默认值来指定对应属性的初始值（某些效果可能
//				需要某些特定的参数值来达到需要的效果，虽然这些值可以在之后在进行调整，但是如果默认就指定
//				为想要的值的话就省去了一个个调整的时间，方便很多）。
// 
// type说明：
// Color 		- 以0～1定义的rgba颜色，比如(1,1,1,1)；
// 2D/Rect/Cube - 对于贴图来说，默认值可以为一个代表默认tint颜色的字符串，可以是空字符串或者”white”,
//				  ”black”,”gray”,”bump”中的一个
// Float/Range 	- 某个指定的浮点数
// Vector 		- 一个4维数，写为 (x,y,z,w)
// option		- 它只对2D，Rect或者Cube贴图有关，在写输入时我们最少要在贴图之后写一对什么都不含的
//				  空白的{}，当我们需要打开特定选项时可以把其写在这对花括号内。如果需要同时打开多个选项，
//				  可以使用空白分隔。可能的选择有ObjectLinear, EyeLinear, SphereMap, CubeReflect, 
//				  CubeNormal中的一个，这些都是OpenGL中TexGen的模式，具体的留到后面有机会再说。

// SubShader说明:
// Tags		- 指定渲染标识，硬件将通过判定这些标签来决定什么时候调用该着色器。常用的tag有：
// 		"RenderType"="Opaque"	在渲染非透明物体时调用
// 		"RenderType" = "Transparent"	在含有透明效果的物体时调用
// 		"IgnoreProjector"="True" 	不被Projectors影响
// 		"ForceNoShadowCasting"="True"	从不产生阴影
// 		"Queue"="xxx"	指定渲染顺序队列，预定义的Queue有:
// 			Background 	- 最早被调用的渲染，用来渲染天空盒或者背景
// 			Geometry 	- 这是默认值，用来渲染非透明物体（普通情况下，场景中的绝大多数物体应该是非透明的）
// 			AlphaTest 	- 用来渲染经过Alpha Test的像素，单独为AlphaTest设定一个Queue是出于对效率的考虑
// 			Transparent - 以从后往前的顺序渲染透明物体
// 			Overlay 	- 用来渲染叠加的效果，是渲染的最后阶段（比如镜头光晕等特效）
// 			这些预定义的值本质上是一组定义整数，Background = 1000， Geometry = 2000, AlphaTest = 2450， 
// 			Transparent = 3000，最后Overlay = 4000。在我们实际设置Queue值时，不仅能使用上面的几个预定义值，
// 			我们也可以指定自己的Queue值，写成类似这样："Queue"="Transparent+100"，表示一个在Transparent之
// 			后100的Queue上进行调用。通过调整Queue值，我们可以确保某些物体一定在另一些物体之前或者之后渲染。
//
// LOD		- 它是Level of Detail的缩写，在这里例子里我们指定了其为200。这个数值决定了我们能用什么样的Shader。
// 			  在Unity的Quality Settings中我们可以设定允许的最大LOD，当设定的LOD小于SubShader所指定的LOD时，
// 			  这个SubShader将不可用。Unity内建Shader定义了一组LOD的数值，我们在实现自己的Shader的时候可以将其
// 			  作为参考来设定自己的LOD数值，这样在之后调整根据设备图形性能来调整画质时可以进行比较精确的控制。

// CGPROGRAM- 表明一段CG程序的开始
// ENDCG	- 表明一段CG程序的结束
// #pragma surface surf Lambert - 指定shader类型为表面Shader，着色器函数名为surf，光照模型为Lambert。格式如下：
//			#pragma surface surfaceFunction lightModel [optionalparams]
// 			surface表示是一个表面着色器,surfaceFunction表示着色器代码的方法的名字，lightModel表示使用的光照模型。

// Fallback
// 每个shader包含多个子shader, 至少包含有一个。当加载shader时，Unity会遍历所有子shader.从上往下选择第一个可以支持的。 
// 如果没有可以支持的， Unity会试着用Fallback shader.

// Pass 	- 通道,基本通道命令包含一个可选的渲染设置命令的列表,和可选的被使用的纹理的列表，格式为：
//			  Pass {[Name and Tasgs] [RenderSetup] [TextureSetup]}
// 			- Name and Tags表示 名字 和 任意个数标签(key/value对，用于进行通道与引擎间交互)。
// 			- Render Setup 渲染设置。通道设定显示硬件的各种状态，例如能打开alpha混合，能使用雾，等等。这些命令如下：
//  			Material { Material Block }	- 定义一个使用顶点光照管线的材质。
// 				Lighting On | Off			- 开启或关闭顶点光照
// 				Cull Back | Front | Off		- 设置多边形剔除模式
// 				ZTest (Less | Greater | LEqual | GEqual | Equal | NotEqual | Always)	- 设置深度测试模式
// 				ZWrite On | Off				- 设置深度写模式
// 				Fog { Fog Block }			- 设置雾参数
//  
// 				AlphaTest (Less | Greater | LEqual | GEqual | Equal | NotEqual | Always) CutoffValue  - 开启alpha测试
// 				Blend SourceBlendMode DestBlendMode		- 设置alpha混合模式
// 				Color Color value			- 设置当顶点光照关闭时所使用的颜色
// 				ColorMask RGB | A | 0 | any combination of R, G, B, A	- 设置颜色写遮罩。设置为0将关闭所有颜色通道的渲染
// 				Offset OffsetFactor , OffsetUnits	- 设置深度偏移
// 				SeparateSpecular On | Off	- 开启或关闭顶点光照相关的平行高光颜色
// 				ColorMaterial AmbientAndDiffuse | Emission	- 当计算顶点光照时使用每顶点颜色
// 				Texture Setup 				- 纹理设置
// 				SetTexture texture property { [Combine options] }	- 配置了 固定函数多纹理管线，当自定义fragment shaders 
//											  被使用时，将忽略这个设置。在完成渲染设定后，你能指定一定数量的纹理和当使用 
//											  SetTexture 命令时所采用的混合模式：
// 				Per-pixel Lighting 			- 每像素光照.每像素光照管线通过多次通道渲染对象来完成。Unity渲染对象一次来获取阴影色
//											  和任何顶点光照。然后再在额外的并行通道中渲染出每像素光照的效果。参考Render Pipeline。
// 				Per-vertex Lighting 		- 每顶点光照.每顶点光照是标准的Direct3D/OpenGL光照模式，通过计算每个顶点的光照来完成。
// 											  Lighting on命令开启光照。光照被材质块，颜色材质和平行高光命令所影响

// struct SurfaceOutput
// {
//     fixed3 Albedo;  // 反射率
//     fixed3 Normal;  // 法线
//     fixed3 Emission;	// 自发光，用于增强物体自身的亮度，使之看起来好像可以自己发光
//     half Specular;  // 镜面 in 0..1 range
//     fixed Gloss;    // 光泽
//     fixed Alpha;    // 透明
// };

Shader "Custom/testDiffuse" {
	Properties{		
		_EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_MySliderValue ("RangeValue", Range(0,10)) = 2.5
		_Texture ("TextureValue", 2D) = "white" {} 
		_Rect ("RectValue", Rect) = "gray" {} 
		_Cube ("CubeValue", Cube) = "bump" {} 
		_Float ("FloatValue", Float) = 0.5
		_Vector ("VectorValue", Vector) = (0.5, 0.5, 0.5, 0.5) 
	}
	SubShader{
		Tags { "RenderType"="Opaque" "IgnoreProjector"="True"}		// 指定标识
		LOD 200
		CGPROGRAM
		#pragma surface surf Lambert
		
		// 在CGPROGRAM内部声明属性中的变量，这样我们就可以访问属性值了
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _MySliderValue;
		struct Input{
			float2 uv_MainTex;
		};
		void surf (Input IN, inout SurfaceOutput o){
			//We can then use the properties values in our shader
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), _MySliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a; 
		}
		ENDCG
	}
	SubShader {
	    Pass {
	        Lighting Off
	        SetTexture [_Texture] {} 
	    }
	}
	FallBack "Diffuse"
}
