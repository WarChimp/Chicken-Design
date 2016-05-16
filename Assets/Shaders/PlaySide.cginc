#include "UnityCG.cginc"

float4 TransformPosition(appdata_full v)
{
	return mul (UNITY_MATRIX_MVP, v.vertex);
}
