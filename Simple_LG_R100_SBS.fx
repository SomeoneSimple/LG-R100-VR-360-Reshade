//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simple LG R100 3D SBS shader 																						//
// Rotates stereoscopic SBS backbuffer for LG R100 HMD.																	//
// By SomeoneSimple : https://github.com/SomeoneSimple/LG-R100-VR-360-Reshade											//
//																														//
// Typically this should be loaded last in Reshade. 						  											// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Built on top of Marty McFly's flip shader: https://reshade.me/forum/shader-discussion/3009-flip-and-mirror-entire-image
// Should be combined with BlueSkyDefender's Polynomial-Barrel-Distortion shader to fix the (minimal) pincushion distortion, 
// and/or aspect ratio when using non-native resolutions (as in not 1440x960, e.g. 1080p/1440p):
// https://github.com/BlueSkyDefender/Depth3D/blob/master/Shaders/Polynomial_Barrel_Distortion.fx


#include "ReShade.fxh"

sampler BackBuffer
{
	Texture = ReShade::BackBufferTex;
	AddressU = BORDER;
	AddressV = BORDER;
	AddressW = BORDER;
};	

float4 FlipPass(float4 vpos : SV_Position, float2 texcoord : TexCoord) : SV_Target
{
	float2 tempcoord;

	float2 coordL = texcoord;		// left eye
	coordL.y = texcoord.y * 0.5;	// overscale SBS
	coordL.x = 1-coordL.x;			// invert X
	coordL.y = coordL.y - 0.5; 		// offset Y to center
	coordL.x = coordL.x - 0.75;		// offset X to 75%
	coordL.x = coordL.x * 2;		// half size
	tempcoord.x = coordL.y; 		// horizontal rotate
	tempcoord.y = coordL.x; 		// vertical rotate
	coordL = tempcoord;

	float2 coordR = texcoord;		// right eye
	coordR.y = texcoord.y * 0.5;	// overscale SBS
	coordR.y = 1-coordR.y;			// invert Y
	coordR.y = coordR.y - 0.5; 		// offset Y to center + SBS offset
	coordR.x = coordR.x - 0.75;		// offset X to 75%
	coordR.x = coordR.x * 2;		// half size
	tempcoord.x = coordR.y; 		// horizontal rotate
	tempcoord.y = coordR.x; 		// vertical rotate
	coordR = tempcoord;

	float4 colorL = tex2D(BackBuffer, coordL + 0.5);
	float4 colorR = tex2D(BackBuffer, coordR + 0.5);
	float4 color = texcoord.x < 0.5 ? colorL : colorR;
	return color;
}


technique Simple_LG_R100_SBS
{
	pass
	{
	VertexShader = PostProcessVS;
	PixelShader = FlipPass;
	}
}
