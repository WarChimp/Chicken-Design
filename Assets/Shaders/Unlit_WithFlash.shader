Shader "PlaySide/Unlit_WithFlash" {
   Properties {
   _Color ("Main Color", Color) = (1,1,1,1)
	  _MainTex ("Texture", 2D) = "white" {}
	  [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2.0 // Back
	  [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4.0 // LessEqual
	  [MaterialToggle] _ZWrite ("Z Write", Float) = 1
	}
	
	SubShader {
	  Tags { "RenderType"="Opaque" "Queue" = "Geometry" }
	 Pass
		{
			Cull [_CullMode]
			ZTest [_ZTest]
			ZWrite [_ZWrite]
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "PlaySide.cginc"

			sampler2D _MainTex;
			fixed4 _Color;
			float4 _MainTex_ST;

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 color : COLOR;
			};

			v2f vert (appdata_full v)
			{				
				v2f o;
				o.pos = TransformPosition(v);
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
				o.color = v.color.rgb;
				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half3 col = i.color+(_Color.rgb*_Color.a);
				
				return half4(col, 1);
			}
			ENDCG
		}
	}
}
