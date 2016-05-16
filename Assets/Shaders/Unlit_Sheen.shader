Shader "PlaySide/UnlitSheen" {
   Properties {
	  _MainTex ("Texture", 2D) = "white" {}
	  _ShineTex ("Shine Texture", 2D) = "black" {}
	  _Color ("Sheen Color", Color) = (1,1,1,1)
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
			float4 _MainTex_ST;
			sampler2D _ShineTex;
			float4 _Color;

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvShine : TEXCOORD3;
				float3 color : COLOR;
			};

			float2 scrollMask(inout float2 uv){
				if (uv.y >= 10)
					uv.y = -10;
				uv.y += _Time*-10;
				return uv;
			}

			v2f vert (appdata_full v)
			{				
				v2f o;
				o.pos = TransformPosition(v);
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
				o.uvShine = o.uv; 
				o.uvShine = scrollMask(o.uvShine);
				o.color = v.color;
				return o;
			}
			
			half4 frag (v2f i) : COLOR 
			{
				half3 col = tex2D(_MainTex, i.uv.xy).rgb*i.color.rgb;
				fixed shine = tex2D(_ShineTex, i.uvShine).r;

				col += shine * _Color * _Color.a;

				return half4(col, 1);
			}
			ENDCG
		}
	}
}
