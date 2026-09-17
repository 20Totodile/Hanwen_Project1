#ifndef THETOONSHADER_FUNCTION
#define THETOONSHADER_FUNCTION








        

































struct GeneralStylingData
{
    half enableDistanceFade;
    float distanceFadeStartDistance;
    float distanceFadeFalloff;
    half adjustDistanceFadeValue;
    float distanceFadeValue;
};


struct StylingData
{
    half isEnabled;
    half style;
    half type;
    float4 color;
    float rotation;
    float rotationBetweenCells;
    float density;
    float offset;
    float size;
    float sizeControl;
    float sizeFalloff;
    float roundness;
    float roundnessFalloff;
    float hardness;
    float opacity;
    float opacityFalloff;
};

struct StylingRandomData
{
    float enableRandomizer;
    float perlinNoiseSize;
    float perlinNoiseSeed;
    float whiteNoiseSeed;
    
    float noiseIntensity;
    
    half spacingRandomMode;
    float spacingRandomIntensity;

    half opacityRandomMode; 
    float opacityRandomIntensity;

    half lengthRandomMode;
    float lengthRandomIntensity;

    half hardnessRandomMode;
    float hardnessRandomIntensity;

    half thicknessRandomMode; 
    float thicknesshRandomIntensity;
    
   
   

};

struct AdditionalStylingSpecularData
{
    
};

struct AdditionalStylingRimData
{
    
};

struct PositionAndBlendingData
{
    half position;
    half blending;
    half isInverted;
};

struct UVSets
{
    float2 uv0;
    float2 uv1;
    float2 uv2;
    float2 uv3;
};

struct UVSpaceData
{
    half drawSpace;
    half uvSet;
    half coordinateSystem;
    half polarCenterMode;
    float4 polarCenter;
    half sSCameraDistanceScaled;
    half anchorSSToObjectsOrigin;
};


struct NoiseSampleData
{
    float perlinNoise;
    float perlinNoiseFloored;
    float whiteNoise;
    float whiteNoiseFloored;
};

struct RequiredNoiseData
{
    bool perlinNoise;
    bool perlinNoiseFloored;
    bool whiteNoise;
    bool whiteNoiseFloored;
};


#define UNITY_TWO_PI        6.28318530718f

float shiftLinear(
float ll0, float lll0
)
{
    float llll0 = (ll0 - lll0) / max(lll0 + 1.0, 1e-6);
    float lllll0 = (ll0 - lll0) / max(1.0 - lll0, 1e-6);
    return lerp(llll0, lllll0, step(lll0, ll0)); 
}
float sum(
float3 lllllll0
)
{
   return dot(lllllll0, float3(1, 1, 1));
}
float invLerp(
float lllllllll0, float llllllllll0, float ll0
)
{
    return (ll0 - lllllllll0) / (llllllllll0 - lllllllll0);
}
float4 invLerp(
float4 lllllllll0, float4 llllllllll0, float4 ll0
)
{
    return (ll0 - lllllllll0) / (llllllllll0 - lllllllll0);
}
float remap(
float lllllllllllllllll0, float llllllllllllllllll0, float lllllllllllllllllll0, float llllllllllllllllllll0, float ll0
)
{
    float llllllllllllllllllllll0 = invLerp(lllllllllllllllll0, llllllllllllllllll0, ll0);
    return lerp(lllllllllllllllllll0, llllllllllllllllllll0, llllllllllllllllllllll0);
}
float2 GetScreenUV(
float2 llllllllllllllllllllllll0, float lllllllllllllllllllllllll0
)
{
#if _URP
    float4 llllllllllllllllllllllllll0 = TransformObjectToHClip(float3(0, 0, 0));
#else
    float4 llllllllllllllllllllllllll0 = UnityObjectToClipPos(float3(0, 0, 0));
#endif
    float2 llllllllllllllllllllllllllll0 = float2(llllllllllllllllllllllll0.x, llllllllllllllllllllllll0.y);
    float lllllllllllllllllllllllllllll0 = _ScreenParams.y / _ScreenParams.x;
    llllllllllllllllllllllllllll0.x -= llllllllllllllllllllllllll0.x / (llllllllllllllllllllllllll0.w);
    llllllllllllllllllllllllllll0.y -= llllllllllllllllllllllllll0.y / (llllllllllllllllllllllllll0.w);
    llllllllllllllllllllllllllll0.y *= lllllllllllllllllllllllllllll0;
    llllllllllllllllllllllllllll0 *= 1 / lllllllllllllllllllllllll0;
    llllllllllllllllllllllllllll0 *= llllllllllllllllllllllllll0.z;
    return llllllllllllllllllllllllllll0;
};
float2 toPolar(
float2 lllllllllllllllllllllllllllllll0
)
{
    float l1 = length(lllllllllllllllllllllllllllllll0);
    float ll1 = atan2(lllllllllllllllllllllllllllllll0.y, lllllllllllllllllllllllllllllll0.x);
    return float2(ll1 / UNITY_TWO_PI, l1);
}
float2 ConvertToDrawSpace(
#if _URP
    InputData inputData, 
#else
    float3 llll1,
    float3 lllll1,
#endif
float2 lllllllll1, UVSpaceData uvSpaceData, float4 llllllllllllllllllllllllllll0, UVSets uvSets
)
{
    #if _URP
        float3 llll1 = inputData.positionWS;
        float3 lllll1 = inputData.normalWS;
    #endif      
    if (uvSpaceData.drawSpace == 0)    
    {
        if (uvSpaceData.uvSet == 0.0)
        {
            lllllllll1 = uvSets.uv0;
        }
        else if (uvSpaceData.uvSet == 1.0)
        {
            lllllllll1 = uvSets.uv1;
        }
        else if (uvSpaceData.uvSet == 2.0)
        {
            lllllllll1 = uvSets.uv2;
        }
        else if (uvSpaceData.uvSet == 3.0)
        {
            lllllllll1 = uvSets.uv3;
        }
    }
    else if (uvSpaceData.drawSpace == 1)    
    {            
        float4 llllllllllllllllllllllll0 = mul(UNITY_MATRIX_VP, float4(llll1, 1.0));
        float4 llllllllllllll1 = ComputeScreenPos(llllllllllllllllllllllll0);
        lllllllll1 = ((llllllllllllll1.xy) / llllllllllllll1.w); 
        if (uvSpaceData.anchorSSToObjectsOrigin)
        {
            float4 lllllllllllllll1 = mul(UNITY_MATRIX_VP, float4(_WorldSpaceCameraPos, 1.0));
            float2 llllllllllllllll1 = lllllllllllllll1.xy / lllllllllllllll1.w;
            float2 lllllllllllllllll1 = llllllllllllllllllllllllllll0.xy;
            lllllllll1 = lllllllll1 - lllllllllllllllll1; 
        }
    }
    else if (uvSpaceData.drawSpace == 2)    
    {
        float3 lllllllllllllllllll1 = abs(lllll1);
        if (lllllllllllllllllll1.x > lllllllllllllllllll1.y && lllllllllllllllllll1.x > lllllllllllllllllll1.z)
        {
            lllllllll1 = llll1.yz;
        }
        else if (lllllllllllllllllll1.y > lllllllllllllllllll1.z)
        {
            lllllllll1 = llll1.xz;
        }
        else
        {
            lllllllll1 = llll1.xy;
        }
    }
    if (uvSpaceData.coordinateSystem == 1) 
    {
        if (uvSpaceData.drawSpace == 1)
        {
            if (uvSpaceData.polarCenterMode == 0) 
            {
                lllllllll1.xy -= uvSpaceData.polarCenter.xy;
            }
            else 
            {
                uvSpaceData.polarCenter.a = 1;
                float4 llllllllllllllllllll1 = mul(UNITY_MATRIX_VP, uvSpaceData.polarCenter);
                float4 lllllllllllllllllllll1 = ComputeScreenPos(llllllllllllllllllll1);
                float2 llllllllllllllllllllll1 = lllllllllllllllllllll1.xy / lllllllllllllllllllll1.w;
                lllllllll1.xy -= llllllllllllllllllllll1;
            }
        }
        else
        {
            lllllllll1.xy -= uvSpaceData.polarCenter.xy;
        }
    }
    if (uvSpaceData.coordinateSystem == 1) 
    {
        lllllllll1 = toPolar(lllllllll1);
    }
    if (uvSpaceData.drawSpace == 1)
    {
        if (uvSpaceData.sSCameraDistanceScaled == 1)
        {
            float3 lllllllllllllllllllllll1 = mul(UNITY_MATRIX_M, float4(0, 0, 0, 1.0)).xyz;
            lllllllll1.xy *= distance(_WorldSpaceCameraPos, lllllllllllllllllllllll1);
        }
        float llllllllllllllllllllllll1 = _ScreenParams.x / _ScreenParams.y;
        lllllllll1.x *= llllllllllllllllllllllll1;
    }
    return lllllllll1;
}
float CalculateSpecularMaskSkipDot(
float llllllllllllllllllllllllll1, float3 lllllllllllllllllllllllllll1, float llllllllllllllllllllllllllll1, float lllllllllllllllllllllllllllll1, float llllllllllllllllllllllllllllll1
)
{
    float lllllllllllllllllllllllllllllll1 = 0;
    float l2 = (1 - (llllllllllllllllllllllllllll1)) * 10; 
    llllllllllllllllllllllllll1 = max(llllllllllllllllllllllllll1, 0); 
    float ll2 = pow(llllllllllllllllllllllllll1, l2 * l2);
    float lll2 = smoothstep(0.8, 0.8 + lllllllllllllllllllllllllllll1 / 1, ll2);
    lllllllllllllllllllllllllllllll1 = lll2 * llllllllllllllllllllllllllllll1 * 5;
    return lllllllllllllllllllllllllllllll1;
}
float CalculateSpecularMask(
float3 lllll2, float3 llllll2, float3 lllllllllllllllllllllllllll1, float llllllllllllllllllllllllllll1, float lllllllllllllllllllllllllllll1, float llllllllllllllllllllllllllllll1
)
{
    float lllllllllllllllllllllllllllllll1 = 0;
    float3 llllllllllll2 = normalize(llllll2 + lllllllllllllllllllllllllll1);
    float llllllllllllllllllllllllll1 = dot(lllll2, llllllllllll2);
    lllllllllllllllllllllllllllllll1 = CalculateSpecularMaskSkipDot(llllllllllllllllllllllllll1, lllllllllllllllllllllllllll1, llllllllllllllllllllllllllll1, lllllllllllllllllllllllllllll1, llllllllllllllllllllllllllllll1);
    return lllllllllllllllllllllllllllllll1;
}
float CalculateRimMask(
float3 lllllllllllllllllllllllllll3, float3 lllllllllllllllllllllllllll1, float lllllllllllllllllllllllllllll3, float llllllllllllllllllllllllllllll3, float llllllllllllllllllllllllllllll1,
                        half l4, half ll4, half lll4, float llll4
)
{
    float lllll4 = 0;         
    float llllll4 = saturate(1 - dot(lllllllllllllllllllllllllll1, lllllllllllllllllllllllllll3));
    lllllllllllllllllllllllllllll3 = 1 - lllllllllllllllllllllllllllll3;
    float lllllll4 = smoothstep(saturate(lllllllllllllllllllllllllllll3 - llllllllllllllllllllllllllllll3), lllllllllllllllllllllllllllll3, llllll4);
    if ((l4 == 0 && llllllllllllllllllllllllllllll1 > 0.0 && ((llll4 >= 0 || ll4 == 0) || lll4 == 0))
    || (l4 == 1 && (llllllllllllllllllllllllllllll1 <= 0.0 || (llll4 <= 2 && ll4 == 1)))
    || l4 == 2 )
    {
        if (l4 == 1)
        {
            float llllllll4 = llllllllllllllllllllllllllllll1;
            if (ll4)
            {
                if (llllllllllllllllllllllllllllll1 > 0)
                {
                    llllllllllllllllllllllllllllll1 *= llll4;
                }
            }
            {
                float lllllllll4 = 1 - abs(min(llllllllllllllllllllllllllllll1 * 2 , 0)); 
                if (llllllll4 > 0)
                {
                    lllllllll4 = llll4;
                }
                lllll4 = lllllll4 * (1 - lllllllll4);
            }
        }
        else if (l4 == 0)
        {
            lllll4 = lllllll4 * (llllllllllllllllllllllllllllll1 * 2) * (llll4);
        }
        else if (l4 == 2)
        {
            lllll4 = lllllll4;
        }
    }
    return lllll4;
}
float CalculateRimMask2(
float3 lllllllllllllllllllllllllll3, float3 lllllllllllllllllllllllllll1, float lllllllllllllllllllllllllllll3, float llllllllllllllllllllllllllllll3, float llllllllllllllllllllllllllllll1,
                        half l4, half ll4, half lll4, float llll4
)
{
    float lllll4 = 0;        
    float llllll4 = saturate(1 - dot(lllllllllllllllllllllllllll1, lllllllllllllllllllllllllll3));
    lllllllllllllllllllllllllllll3 = 1 - lllllllllllllllllllllllllllll3;
    float lllllll4 = smoothstep(saturate(lllllllllllllllllllllllllllll3 - llllllllllllllllllllllllllllll3), lllllllllllllllllllllllllllll3, llllll4);
    if ((l4 == 0 && llllllllllllllllllllllllllllll1 > 0.0 && ((llll4 >= 0 || ll4 == 0) || lll4 == 0))
    || (l4 == 1 && (llllllllllllllllllllllllllllll1 <= 0.0 || (llll4 <= 2 && ll4 == 1)))
    || l4 == 2)
    {
        if (l4 == 1)
        {
            if (ll4)
            {
                lllll4 = lllllll4 * (1 - llll4);
            }
            else
            {
                float lllllllll4 = 1 - abs(min(llllllllllllllllllllllllllllll1 * 2, 0)); 
                float lllllll0 = lerp(0, lllllllll4 * 4, llllllllllllllllllllllllllllll3);
                lllll4 = lllllll4 * (1 - lllllllll4);
            }
        }
        else if (l4 == 2)
        {
            lllll4 = lllllll4; 
        }
        else
        {
            lllll4 = lllllll4 * (llllllllllllllllllllllllllllll1 * 2) * (llll4);
        }
    }
    return lllll4;
}
float2 RotateUV(
float2 lllllllll1, float ll1
)
{
    float llllllllllllllllllllllllllll4 = radians(ll1);
    float lllllllllllllllllllllllllllll4= cos(llllllllllllllllllllllllllll4);
    float llllllllllllllllllllllllllllll4= sin(llllllllllllllllllllllllllll4);
    float2 lllllllllllllllllllllllllllllll4;
    lllllllllllllllllllllllllllllll4.x = lllllllll1.x * lllllllllllllllllllllllllllll4 - lllllllll1.y * llllllllllllllllllllllllllllll4;
    lllllllllllllllllllllllllllllll4.y = lllllllll1.x * llllllllllllllllllllllllllllll4 + lllllllll1.y * lllllllllllllllllllllllllllll4;
    return lllllllllllllllllllllllllllllll4;
}
float2 RotateUVRadians(
float2 lllllllll1, float lll5
)
{
    float llllllllllllllllllllllllllll4 = lll5;                
    float lllllllllllllllllllllllllllll4 = cos(llllllllllllllllllllllllllll4);
    float llllllllllllllllllllllllllllll4 = sin(llllllllllllllllllllllllllll4);
    float2 lllllllllllllllllllllllllllllll4;
    lllllllllllllllllllllllllllllll4.x = lllllllll1.x * lllllllllllllllllllllllllllll4 - lllllllll1.y * llllllllllllllllllllllllllllll4;
    lllllllllllllllllllllllllllllll4.y = lllllllll1.x * llllllllllllllllllllllllllllll4 + lllllllll1.y * lllllllllllllllllllllllllllll4;
    return lllllllllllllllllllllllllllllll4;
}
NoiseSampleData SampleNoiseData(
float2 lllllllll1, StylingData stylingData, StylingRandomData stylingRandomData, RequiredNoiseData requiredNoiseData, 
#ifdef USE_UNITY_TEXTURE_2D_TYPE
    UnityTexture2D lllllllll5, UnityTexture2D llllllllll5
#else
    sampler2D lllllllll5, sampler2D llllllllll5
#endif
)
{
    NoiseSampleData noiseSampleData;
    if (stylingRandomData.enableRandomizer == 1)
    {
        if (stylingData.style == 1)
        {
            if (fmod(floor(lllllllll1.y * stylingData.density), 2) == 0)
            {
                lllllllll1.x += stylingData.offset / stylingData.density;
            }
        }
        float lllllllllll5 = 0;
        if (requiredNoiseData.perlinNoiseFloored == 1)
        {
            float2 llllllllllll5 = lllllllll1;
            llllllllllll5.x = floor(lllllllll1.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 0)
            {
            }
            else if (stylingData.style == 1)
            {
                llllllllllll5.y = floor(lllllllll1.y * stylingData.density) / stylingData.density;
            }
            llllllllllll5 *= stylingRandomData.perlinNoiseSize;
            lllllllllll5 = tex2Dlod(lllllllll5, float4(llllllllllll5, 0.0, 0.0)).x; 
        }
        float lllllllllllll5 = 0;
        if (requiredNoiseData.perlinNoise == 1)
        {
            float2 llllllllllllll5 = lllllllll1 * stylingRandomData.perlinNoiseSize;
            lllllllllllll5 = tex2Dlod(lllllllll5, float4(llllllllllllll5, 0.0, 0.0)).x; 
        }
        float lllllllllllllll5 = 0;
        if (requiredNoiseData.whiteNoise == 1)
        {
            float2 llllllllllllllll5 = lllllllll1;
            llllllllllllllll5.x = floor(lllllllll1.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 0)
            {
                llllllllllllllll5.y = 0.1;
            }
            else
            if (stylingData.style == 1)
            {
                llllllllllllllll5.y = floor(lllllllll1.y * stylingData.density) / stylingData.density;
            }
            lllllllllllllll5 = tex2Dlod(llllllllll5, float4(llllllllllllllll5, 0.0, 0.0)).x; 
        }
        float lllllllllllllllll5 = 0;
        if (requiredNoiseData.whiteNoiseFloored == 1)
        {
            float2 llllllllllllllllll5 = lllllllll1;
            llllllllllllllllll5.x = floor(lllllllll1.x * stylingData.density) / stylingData.density;
            if (stylingData.style == 1)
            {
                llllllllllllllllll5.y = 0.1;
            }
            lllllllllllllllll5 = tex2Dlod(llllllllll5, float4(llllllllllllllllll5, 0.0, 0.0)).x; 
        }
        noiseSampleData.perlinNoise = lllllllllllll5;
        noiseSampleData.perlinNoiseFloored = lllllllllll5;
        noiseSampleData.whiteNoise = lllllllllllllll5;
        noiseSampleData.whiteNoiseFloored = lllllllllllllllll5;
    }
    else
    {
        noiseSampleData.perlinNoise = 0;
        noiseSampleData.perlinNoiseFloored = 0;
        noiseSampleData.whiteNoise = 0;
        noiseSampleData.whiteNoiseFloored = 0;
    }
    return noiseSampleData;
}
float Hatching(
float ll0, float2 lllllllll1, StylingData hatchingData, StylingRandomData stylingRandomData, NoiseSampleData noiseSampleData, half llllllllllllllllllllll5
)
{
    ll0 = 1 - ll0;   
    float2 lllllllllllllllllllllll5 = lllllllll1;      
    float llllllllllllllllllllllll5 = hatchingData.size / 2;    
    float lllllllllllllllllllllllll5 = lllllllllllllllllllllll5.x;            
    lllllllllllllllllllllllll5 *= hatchingData.density;
    if (stylingRandomData.enableRandomizer == 1)
    {
        lllllllllllllllllllllllll5 += noiseSampleData.perlinNoise * stylingRandomData.noiseIntensity;
        float llllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.thicknessRandomMode == 0)
        {
            llllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.thicknessRandomMode == 1) 
        {
            llllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        llllllllllllllllllllllllll5 *= stylingRandomData.thicknesshRandomIntensity;
        float lllllllllllllllllllllllllll5 = remap(0, 1, 0.0, llllllllllllllllllllllll5, llllllllllllllllllllllllll5);
        llllllllllllllllllllllll5 -= lllllllllllllllllllllllllll5;
        float llllllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.spacingRandomMode == 0)
        {
            llllllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.spacingRandomMode == 1) 
        {
            llllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lllllllllllllllllllllllllllll5 = remap(0, 1, -0.5 + llllllllllllllllllllllll5, 0.5 - llllllllllllllllllllllll5, llllllllllllllllllllllllllll5);
        lllllllllllllllllllllllll5 += lllllllllllllllllllllllllllll5 * stylingRandomData.spacingRandomIntensity * saturate(1 - stylingRandomData.noiseIntensity); 
    }
    lllllllllllllllllllllllll5 = abs(frac(lllllllllllllllllllllllll5) - 0.5);
    float llllllllllllllllllllllllllllll5 = 0;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.lengthRandomMode == 0)
        {
            lllllllllllllllllllllllllllllll5 = noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity); 
        }
        else if (stylingRandomData.lengthRandomMode == 1)
        {
            lllllllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored; 
        }
        else
        {
            lllllllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity))) / 2); 
        }
        float l6 = lllllllllllllllllllllllllllllll5 * stylingRandomData.lengthRandomIntensity;
        llllllllllllllllllllllllllllll5 = remap(0, 1 - l6, 0, 1, ll0);    
    }
    else
    {
        llllllllllllllllllllllllllllll5 = remap(0, 1, 0, 1, ll0);;
    }    
    float ll6 = smoothstep(min(1 - hatchingData.sizeFalloff, 0.99), 1, llllllllllllllllllllllllllllll5);
    ll6 = max(llllllllllllllllllllllll5 - ll6, 0);
    float lll6 = 0;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llll6 = 0;
        if (stylingRandomData.hardnessRandomMode == 0) 
        {
            llll6 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.hardnessRandomMode == 1) 
        {
            llll6 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else
        {
            llll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        lll6 = remap(0, 1, 0, ll6, min(saturate(hatchingData.hardness - llll6 * stylingRandomData.hardnessRandomIntensity), hatchingData.hardness));
    }
    else
    {
        lll6 = remap(0, 1, 0, ll6, hatchingData.hardness);
    }
    if (ll6 != 0 )
    {
        float lllll6 = 0;
        if (llllllllllllllllllllll5)
        {
            lllll6 = fwidth(lllllllllllllllllllllllll5); 
        }
        if (ll6 == llllllllllllllllllllllll5 && hatchingData.size == 1)
        {
            lllll6 = 0;
        }                        
        if (lll6 - lllll6 < 0) 
        {
            lllll6 = 0;
        }
        lllllllllllllllllllllllll5 = smoothstep(lll6 - lllll6, ll6 + lllll6, lllllllllllllllllllllllll5);
    }
    else
    {
        lllllllllllllllllllllllll5 = 1; 
    }
    lllllllllllllllllllllllll5 = 1 - lllllllllllllllllllllllll5;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllll6;
        if (stylingRandomData.opacityRandomMode == 0) 
        {
            llllll6 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.opacityRandomMode == 1) 
        {
            llllll6 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else 
        {
            llllll6 = ((noiseSampleData.perlinNoiseFloored * 5) + noiseSampleData.whiteNoise) / 2;
            llllll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        lllllllllllllllllllllllll5 = saturate(lllllllllllllllllllllllll5 - (llllll6 * stylingRandomData.opacityRandomIntensity));
    }
    float lllllll6 = smoothstep(min(1-hatchingData.opacityFalloff, 0.99), 1, llllllllllllllllllllllllllllll5);
    lllllllllllllllllllllllll5 *= 1 - lllllll6;
    lllllllllllllllllllllllll5 *= hatchingData.opacity;
    return lllllllllllllllllllllllll5;
}
float Halftones(
float ll0, float2 lllllllll1, StylingData halftonesData, StylingRandomData stylingRandomData, NoiseSampleData noiseSampleData
)
{            
    float2 lllllllllll6 = lllllllll1;               
    lllllllllll6 *= halftonesData.density;
    if (stylingRandomData.enableRandomizer == 1)
    {
        lllllllllll6 += noiseSampleData.perlinNoise * stylingRandomData.noiseIntensity;
    }
    if (fmod(floor(lllllllllll6.y), 2) == 0)
    {
        lllllllllll6.x += halftonesData.offset;
    }
    if (stylingRandomData.enableRandomizer == 1)
    {
        float lllllllllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.lengthRandomMode == 0)
        {
            lllllllllllllllllllllllllllllll5 = noiseSampleData.whiteNoiseFloored * saturate(1 - stylingRandomData.noiseIntensity); 
        }
        else if (stylingRandomData.lengthRandomMode == 1)
        {
            lllllllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored; 
        }
        else
        {
            lllllllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomData.noiseIntensity))) / 2); 
        }
        float l6 = lllllllllllllllllllllllllllllll5 * stylingRandomData.lengthRandomIntensity;
        ll0 -= l6;
    }
    float llllllllllllll6 = halftonesData.size;
    if (halftonesData.sizeControl == 1)  
    {
        llllllllllllll6 *= ll0;
    }
    else
    {
        float lllllllllllllll6 = smoothstep(min(1 - halftonesData.sizeFalloff, 1), 1, (1 - ll0)); 
        llllllllllllll6 = max(llllllllllllll6 - lllllllllllllll6, 0);
    }
    llllllllllllll6 /= 2;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.thicknessRandomMode == 0)
        {
            llllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.thicknessRandomMode == 1) 
        {
            llllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lllllllllllllllll6 = remap(0, 1, 0.0, llllllllllllll6, llllllllllllllllllllllllll5 * stylingRandomData.thicknesshRandomIntensity);
        llllllllllllll6 -= lllllllllllllllll6;
    }
    float llllllllllllllllll6 = 1 - halftonesData.roundness;
    float lllllllllllllllllll6 = smoothstep(halftonesData.roundnessFalloff, 1, 1 - ll0);
    llllllllllllllllll6 = max(llllllllllllllllll6 - lllllllllllllllllll6 * 4, 0);
    llllllllllllllllll6 /= 2;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllllllllllllllllllllllllll5 = 0;
        if (stylingRandomData.spacingRandomMode == 0)
        {
            llllllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.spacingRandomMode == 1) 
        {
            llllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
        }
        else 
        {
            llllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
        }
        float lllllllllllllllllllllllllllll5 = remap(0, 1, -0.5 + llllllllllllll6, 0.5 - llllllllllllll6, llllllllllllllllllllllllllll5);
        lllllllllll6 += lllllllllllllllllllllllllllll5 * stylingRandomData.spacingRandomIntensity * saturate(1 - stylingRandomData.noiseIntensity); 
    }
    float llllllllllllllllllllll6 = halftonesData.hardness;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llll6 = 0;
        if (stylingRandomData.hardnessRandomMode == 0) 
        {
            llll6 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.hardnessRandomMode == 1) 
        {
            llll6 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else
        {
            llll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        llllllllllllllllllllll6 = min(saturate(halftonesData.hardness - llll6 * stylingRandomData.hardnessRandomIntensity), halftonesData.hardness);
    }
    float llllllllllllllllllllllll6 = remap(0, 1, 0, llllllllllllll6, llllllllllllllllllllll6);
    float l1 = length(max(abs(frac(lllllllllll6) - 0.5) - llllllllllllllllll6 * llllllllllllllllllllllll6 * 2, 0.0)) + llllllllllllllllll6 * llllllllllllllllllllllll6 * 2;
    float llllllllllllllllllllllllll6 = smoothstep(llllllllllllllllllllllll6, llllllllllllll6, l1);
    llllllllllllllllllllllllll6 = 1 - llllllllllllllllllllllllll6;
    if (stylingRandomData.enableRandomizer == 1)
    {
        float llllll6;
        if (stylingRandomData.opacityRandomMode == 0) 
        {
            llllll6 = noiseSampleData.whiteNoise;
        }
        else if (stylingRandomData.opacityRandomMode == 1) 
        {
            llllll6 = noiseSampleData.perlinNoiseFloored * 5;
        }
        else 
        {
            llllll6 = ((noiseSampleData.perlinNoiseFloored * 5) + noiseSampleData.whiteNoise) / 2;
            llllll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
        }
        llllllllllllllllllllllllll6 = saturate(llllllllllllllllllllllllll6 - (llllll6 * stylingRandomData.opacityRandomIntensity));
    }
    float llllllllllllllllllllllllllll6 = smoothstep(min(1-halftonesData.opacityFalloff, 0.99), 1, 1 - ll0);
    if (halftonesData.type == 1 || halftonesData.opacityFalloff != 0)
    {
        llllllllllllllllllllllllll6 *= 1 - llllllllllllllllllllllllllll6;
    }
    llllllllllllllllllllllllll6 *= halftonesData.opacity;
    llllllllllllllllllllllllll6 = 1 - llllllllllllllllllllllllll6;
    return llllllllllllllllllllllllll6;
}
void DoBlending(
inout float4 lllllllllllllllllllllllllllll6, float ll0, float lllllllllllllllllllllllllllllll6, float4 l7
)
{
    if (lllllllllllllllllllllllllllllll6 == 0) 
    {
        lllllllllllllllllllllllllllll6 = lerp(lllllllllllllllllllllllllllll6, l7, ll0);
    }
    else if (lllllllllllllllllllllllllllllll6 == 1) 
    {        
        lllllllllllllllllllllllllllll6 += (l7 * ll0);
    }
    else if (lllllllllllllllllllllllllllllll6 == 2) 
    {
        lllllllllllllllllllllllllllll6 *= 1-ll0 + (l7 * ll0); 
    }
    else if (lllllllllllllllllllllllllllllll6 == 3) 
    {
        lllllllllllllllllllllllllllll6 -= (l7 * ll0);
    }
    else if (lllllllllllllllllllllllllllllll6 == 4) 
    {
        lllllllllllllllllllllllllllll6 = lerp(lllllllllllllllllllllllllllll6, l7, ll0);
    }
}
void DoToonShading(
#if _URP
    InputData inputData, 
    SurfaceData surface,
#else
#if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
                 SurfaceOutputStandardSpecular o,
#elif _BDRFLAMBERT || _BDRF3 || _SIMPLELIT
                 SurfaceOutput o,
#else
                 SurfaceOutputStandard o,
#endif
    UnityGI gi,
#if !_PASSFORWARDADD
    UnityGIInput giInput,
#endif
#endif
    ShaderData d,
#if _URP
#if UNITY_VERSION >= 202120
    float3 llllllll7,
#endif
#endif
    inout float4 lllllllllllllllllllllllllllll6,
    int llllllllllllll7, float lllllllllllllll7,
    half llllllllllllllll7,
    half lllllllllllllllll7,
    float2 lllllllll1, float4 llllllllllllllllllllllllllll0,
    sampler2D llllllllllllllllllll7,
    half lllllllllllllllllllll7,
    half llllllllllllllllllllll7,
    half lllllllllllllllllllllll7, half llllllllllllllllllllllll7,
#ifdef USE_UNITY_TEXTURE_2D_TYPE
    UnityTexture2D llllllllllllllllllllllllll7,
#else
    sampler2D llllllllllllllllllllllllll7,
    float4 lllllllllllllllllllllllllll7,
#endif
    half llllllllllllllllllllllllllll7,
    half lllllllllllllllllllllllllllll7, float llllllllllllllllllllllllllllll7,
    half lllllllllllllllllllllllllllllll7, float4 l8,
    float ll8, float lll8, float llll8, float4 lllll8,
    float llllll8, float lllllll8, float llllllll8, half lllllllll8, float4 llllllllll8,
    half lllllllllll8,
    half llllllllllll8, half lllllllllllll8, float4 llllllllllllll8, float lllllllllllllll8, float llllllllllllllll8, float lllllllllllllllll8, half llllllllllllllllll8, half lllllllllllllllllll8,
    half llllllllllllllllllll8, half lllllllllllllllllllll8, float4 llllllllllllllllllllll8, float lllllllllllllllllllllll8, float llllllllllllllllllllllll8, float lllllllllllllllllllllllll8, half llllllllllllllllllllllllll8, half lllllllllllllllllllllllllll8,
    half llllllllllllllllllllllllllll8,
    UVSets uvSets,
    GeneralStylingData generalStylingData,
    half lllllllllllllllllllllllllllll8, half llllllllllllllllllllll5,
    half lllllllllllllllllllllllllllllll8,
    half l9,
    float ll9, float lll9,
    half llll9,
    half lllll9,
    PositionAndBlendingData positionAndBlendingDataShading, UVSpaceData uvSpaceDataShading, StylingData stylingDataShading, StylingRandomData stylingRandomDataShading,
    half llllll9, 
    half lllllll9,
    half llllllll9, float lllllllll9,
    PositionAndBlendingData positionAndBlendingDataCastShadows, UVSpaceData uvSpaceDataCastShadows, StylingData stylingDataCastShadows, StylingRandomData stylingRandomDataCastShadows,
    half llllllllll9,
    half lllllllllll9, float llllllllllll9, float lllllllllllll9, half llllllllllllll9, half lllllllllllllll9,
    half llllllllllllllll9,
    PositionAndBlendingData positionAndBlendingDataSpecular, UVSpaceData uvSpaceDataSpecular, StylingData stylingDataSpecular, StylingRandomData stylingRandomDataSpecular,
    half lllllllllllllllll9, 
    half llllllllllllllllll9, float lllllllllllllllllll9, float llllllllllllllllllll9, half lllllllllllllllllllll9,
    half llllllllllllllllllllll9,
    PositionAndBlendingData positionAndBlendingDataRim, UVSpaceData uvSpaceDataRim, StylingData stylingDataRim, StylingRandomData stylingRandomDataRim,
#ifdef USE_UNITY_TEXTURE_2D_TYPE
    UnityTexture2D lllllllll5, UnityTexture2D llllllllll5, 
#else
    sampler2D lllllllll5, sampler2D llllllllll5,
    float4 lllllllllllllllllllllllll9,
#endif
    float3 llllllllllllllllllllllllll9
)
{
    float4 llllllllllllllllllllllllllll9 = float4(0, 0, 0, 0);
#ifdef USE_UNITY_TEXTURE_2D_TYPE
    llllllllllllllllllllllllllll9 = llllllllllllllllllllllllll7.texelSize;
#else
    llllllllllllllllllllllllllll9 = lllllllllllllllllllllllllll7;
#endif
    #if _URP
        AlphaDiscard(surface.alpha, 0.5);
    #else
    #endif
    float lllllllllllllllllllllllllllll9 = 0;
    float4 llllllllllllllllllllllllllllll9 = lllllllllllllllllllllllllllll6;
    int lllllllllllllllllllllllllllllll9 = llllllllllllll7;
#if _USE_OPTIMIZATION_DEFINES
#if _ENABLE_TOON_SHADING
    lllllllllllllllllllllll7 = 1;
#else
    lllllllllllllllllllllll7 = 0;
#endif
    #if _SHADING_COLOR
    lllllllllllllllllllll7 = 0;
    #else
    lllllllllllllllllllll7 = 1;
    #endif 
#if _ENABLE_STYLING
    llllllllllllllllllllllllllll8 = 1;
#else
    llllllllllllllllllllllllllll8 = 0;
#endif
#if _ENABLE_SHADING_STYLING
    lllllllllllllllllllllllllllllll8 = 1;
#else
    lllllllllllllllllllllllllllllll8 = 0;
#endif
    #if _ENABLE_CASTSHADOWS_STYLING
        llllll9 = 1;
    #else
        llllll9 = 0;
    #endif
    #ifdef _STYLING_CASTSHADOWS_SYNC_WITH_OTHER_STYLING
        lllllll9 = _STYLING_CASTSHADOWS_SYNC_WITH_OTHER_STYLING;
    #endif  
    #if _SHADING_TERMINATORPOSITION
        ll8 = ll8;
    #else
        ll8 = 0;
    #endif
    #if _SHADING_STYLING_TERMINATORPOSITION
        llll9 = llll9;
    #else
        llll9 = 0;
    #endif
    #ifdef _SHADING_STYLING_UVSET
        _UVSet = _SHADING_STYLING_UVSET;
    #endif 
    #ifdef _CASTSHADOWS_STYLING_UVSET
        _CastShadowsUVSet = _CASTSHADOWS_STYLING_UVSET;
    #endif 
    #ifdef _SPECULAR_STYLING_UVSET
        _SpecularUVSet = _SPECULAR_STYLING_UVSET;
    #endif 
    #ifdef _RIM_STYLING_UVSET
        _RimUVSet = _RIM_STYLING_UVSET;
    #endif 
#if _ENABLE_SPECULAR_STYLING
    llllllllll9 = 1;
#else
    llllllllll9 = 0;
#endif
#if _ENABLE_SPECULAR
    llllllllllll8 = 1;
#else
    llllllllllll8 = 0;
#endif
#if _SUM_LIGHTS_BEFORE_POSTERIZATION
    llllllllllllllll7 = 1;
#else
    llllllllllllllll7 = 0;
#endif
#if _SHADING_USE_LIGHT_COLORS
    lllllllllllllllll7 = 1;
#else
    lllllllllllllllll7 = 0;
#endif
#if _SPECULAR_USE_LIGHT_COLORS
    lllllllllllllllllll8 = 1;
#else
    lllllllllllllllllll8 = 0;
#endif
#if _STYLING_SPECULAR_USE_LIGHT_COLORS
    lllllllllllllll9 = 1;
#else
    lllllllllllllll9 = 0;
#endif  
#endif
    float3 lll10;
    if (lllllllllll8 == 0)
    {
        lll10 = llllllllllllllllllllllllll9;
    }
    else
    {
    #if _URP 
        lll10 = inputData.normalWS;
    #else
        lll10 = o.Normal;
    #endif
    }
    float3 lllll2;
    if (llllllllllllllllll8 == 0)
    {
        lllll2 = llllllllllllllllllllllllll9;
    }
    else
    {
    #if _URP 
        lllll2 = inputData.normalWS;
    #else
        lllll2 = o.Normal;
    #endif
    }
    float3 lllll10;
    if (lllllllllllllllllllllllllllll8 == 0)
    {
        lllll10 = llllllllllllllllllllllllll9;
    }
    else
    {
    #if _URP 
        lllll10 = inputData.normalWS;
    #else
        lllll10 = o.Normal;
    #endif        
    }
    float3 lllllllllllllllllllllllllll1 = normalize(d.worldSpaceViewDir);
    float4 lllllllllll10 = 0;
    float llllllllllllllllllllllllllllll1 = -1;
    float lllllllllllll10 = -1;
    half3 llllllllllllll10 = 0;
    float llll4 = 0; 
    float llllllllllllllll10 = 0; 
    float lllllllllllllllllllllllllllllll1 = 0;
    half3 llllllllllllllllll3 = 0;
    float lllllllllllllllllll10 = 0;
    half3 llllllllllllllllllll10 = 0;
    ToonShadingData toonShadingData;
    toonShadingData.enableToonShading = lllllllllllllllllllllll7;
#if _URP
    toonShadingData.normalWS = inputData.normalWS;
#endif
    toonShadingData.normalWSNoMap = llllllllllllllllllllllllll9;
    toonShadingData.cellTransitionSmoothness = lllllllllllllll7;
    toonShadingData.numberOfCells = lllllllllllllllllllllllllllllll9;
    toonShadingData.specularEdgeSmoothness = llllllllllllllll8;
    toonShadingData.shadingAffectByNormalMap = lllllllllll8;
    toonShadingData.specularAffectedByNormalMap = llllllllllllllllll8;
#if _URP
    if ((lllllllllllllllllllll7 == 0 && lllllllllllllllllllllll7 == 1 && (lllllllllllllllllllllllllllllll7 == 1 || llllllllllll8 == 1 || llllll8 == 1)) || (llllllllllllllllllllllllllll8 == 1 && (lllllllllllllllllllllllllllllll8 == 1 || llllll9 == 1 || llllllllll9 == 1)))
    {
        bool lllllllllllllllllllll10 = lllllllllllllllllllll7 == 0 && lllllllllllllllllllllll7 == 1;
        bool llllllllllllllllllllll10 = llllllllllllllllllllllllllll8 == 1 && (lllllllllllllllllllllllllllllll8 == 1 || llllll9 == 1 || llllllllll9 == 1);
        bool lllllllllllllllllllllll10 = lllllllllll8 == lllllllllllllllllllllllllllll8; 
        bool llllllllllllllllllllllll10 = llllllllllllllllll8 == lllllllllllllllllllllllllllll8; 
        float lllllllllllllllllllllllll10 = 1;
        float llllllllllllllllllllllllll10 = 1;
        Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
        float lllllllllllllllllllllllllll10 = max(mainLight.color.x, mainLight.color.y); 
        lllllllllllllllllllllllllll10 = max(lllllllllllllllllllllllllll10, mainLight.color.z);
        float3 l10 = lll10;
        float llllllllllllllllllllllllllll1 = lllllllllllllll8;
        float lllllllllllllllllllllllllllll1 = llllllllllllllll8;
        float llllllllllllllll3 = lllllllllllllllll8;
        float l11 = lllllllllllllllllll8;
        half ll11 = llllllllllll8;
        half lll11 = lllllllllllllllllllllllllllllll7;
        if (!lllllllllllllllllllll10)
        {
            l10 = lllll10;
            lllll2 = lllll10;            
            llllllllllllllllllllllllllll1 = llllllllllll9;
            lllllllllllllllllllllllllllll1 = lllllllllllll9;
            llllllllllllllll3 = _StylingSpecularOpacity;
            l11 = lllllllllllllll9;
            ll11 = llllllllll9;
            lll11 = lllllllllllllllllllllllllllllll8;
            ll8 = llll9;
        } 
        else 
        {
            if(lllllllllllllllllllllllllllllll7 == 0) 
            {
                l10 = lllll10;
                lll11 = lllllllllllllllllllllllllllllll8;
            }
            if(llllllllllll8 == 0) 
            {
                lllll2 = lllll10;           
                ll11 = llllllllll9;
            }
            else 
            {
                if(llllllllllllllllllllll10 && llllllllll9 == 1 && lllllllllll9 == 1) 
                {
                    llllllllllll9 = lllllllllllllll8;
                    lllllllllllll9 = llllllllllllllll8;
                }
            }
        }
        float llll11 = 1;
        if (mainLight.color.r > 0.0 || mainLight.color.g > 0.0 || mainLight.color.b > 0.0)
        {
            llll11 = (mainLight.shadowAttenuation * mainLight.distanceAttenuation);
            half lllll11 = mainLight.distanceAttenuation * lllllllllllllllllllllllllll10;
            llllllllllllllllllllllllllllll1 = dot(mainLight.direction, l10);
            if (ll8 != 0.0)
            {
                llllllllllllllllllllllllllllll1 = shiftLinear(llllllllllllllllllllllllllllll1, max(-0.9999, ll8));
            }            
            if (llllllllllllllllllllllllllllll1 > 0)
            {
                llllllllllllllllllllllllllllll1 *= lllll11;
            }
            if (ll11 || (!lllllllllllllllllllll10 && llllllllll9))
            {
                lllllllllllllllllllllllllllllll1 = CalculateSpecularMask(lllll2, mainLight.direction, lllllllllllllllllllllllllll1, llllllllllllllllllllllllllll1, lllllllllllllllllllllllllllll1, llllllllllllllllllllllllllllll1); 
                lllllllllllllllllllllllllllllll1 *= llllllllllllllll3;
                if( (lllllllllllllllllllll10 && llllll8) || (llllllllllllllllllllllllllll8 && llllll9))
                {
                    lllllllllllllllllllllllllllllll1 = min(lllllllllllllllllllllllllllllll1, mainLight.shadowAttenuation);
                }
                if (l11 == 1)
                {
                    llllllllllllllllll3 = lllllllllllllllllllllllllllllll1 * mainLight.color;
                }
            }
            if (!lllllllllllllllllllll10)
            {
                lllllllllllll10 = llllllllllllllllllllllllllllll1;
                lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1;
                llllllllllllllllllll10 = llllllllllllllllll3;
                lllllllllllllllllllllllllllllll1 = 0;
                llllllllllllllllll3 = 0;
            } 
            else
            {
                if(lllllllllllllllllllllllllllllll7 == 0) 
                {
                    lllllllllllll10 = llllllllllllllllllllllllllllll1;
                }
                if(llllllllllll8 == 0) 
                {
                    lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1;
                    llllllllllllllllllll10 = llllllllllllllllll3;
                    lllllllllllllllllllllllllllllll1 = 0;
                    llllllllllllllllll3 = 0;
                }
            }
            if (llllllllllllllllllllll10 && lllllllllllllllllllll10) 
            {
                if (lllllllllllllllllllllll10 && ll9)
                {
                    lllllllllllll10 = llllllllllllllllllllllllllllll1;
                }
                else
                {
                    if (ll9)
                    {
                        llll9 = ll8;
                    }
                    lllllllllllll10 = dot(mainLight.direction, lllll10);
                    if (llll9 != 0.0)
                    {
                        lllllllllllll10 = shiftLinear(lllllllllllll10, max(-0.9999, llll9));
                    }
                    if (lllllllllllll10 > 0)
                    {
                        lllllllllllll10 *= lllll11; 
                    }
                }
                if (llllllllll9 == 1)
                {
                    if (lllllllllllllllllllllll10 && llllllllllllllllllllllll10 && lllllllllll9 == 1)
                    {
                        lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1;
                        llllllllllllllllllll10 = llllllllllllllllll3;
                    }
                    else
                    {
                        lllllllllllllllllll10 = CalculateSpecularMask(lllll10, mainLight.direction, lllllllllllllllllllllllllll1, llllllllllll9, lllllllllllll9, lllllllllllll10);
                        if(llllll8 || llllll9)
                        {
                            lllllllllllllllllll10 = min(lllllllllllllllllll10, mainLight.shadowAttenuation);
                        }
                        if (lllllllllllllll9 == 1)
                        {
                            llllllllllllllllllll10 = lllllllllllllllllll10 * mainLight.color;
                        }
                    }
                }
            }
            {
                lllllllllllllllllllllllll10 = llll11;
            }
        }
        else
        {
            lllllllllllllllllllllllll10 = 1;
            llll11 = 1;
            llllllllllllllllllllllllllllll1 = -1;
            lllllllllllll10 = -1;
        }
        float llllll11 = 0;
        float lllllll11 = 0;
        float llllllll11 = 0;
        float lllllllll11 = 0;
        float llllllllll11 = 2;
        float lllllllllll11 = 2;
        float llllllllllll11 = 0;
        float lllllllllllll11 = 1;
#if defined(_ADDITIONAL_LIGHTS)  
    #if UNITY_VERSION >= 202200
        uint meshRenderingLayers = GetMeshRenderingLayer();
    #else
        uint meshRenderingLayers = GetMeshRenderingLightLayer();
    #endif
#if USE_CLUSTER_LIGHT_LOOP
        [loop] for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
        {
            Light addLight = GetAdditionalLight(lightIndex, inputData.positionWS, half4(1,1,1,1));       
    #ifdef _LIGHT_LAYERS
            if (IsMatchingLightLayer(addLight.layerMask, meshRenderingLayers))
    #endif
            {
                float llllllllllllllllllllll3 = max(addLight.color.x, addLight.color.y);
                llllllllllllllllllllll3 = max(llllllllllllllllllllll3, addLight.color.z);
                half lllllllllllllll11 = addLight.distanceAttenuation * llllllllllllllllllllll3;
                float llllllllllllllll11 = smoothstep(0, 0.1 / (addLight.distanceAttenuation * llllllllllllllllllllll3), addLight.distanceAttenuation * llllllllllllllllllllll3);
                float lllllllllllllllll11 = smoothstep(0, 0.01, addLight.distanceAttenuation * llllllllllllllllllllll3);
                llllllllllll11 += addLight.shadowAttenuation * lllllllllllllll11;
                float llllllllllllllllll11 = dot(addLight.direction, l10);
                if (ll8 != 0)
                {
                    llllllllllllllllll11 = shiftLinear(llllllllllllllllll11, max(-0.9999, ll8));
                }
                float lllllllllllllllllll11 = lerp(-1, llllllllllllllllll11, llllllllllllllll11);
            {
                    lllllllllllll11 = min(lllllllllllll11, lerp(1, addLight.shadowAttenuation, lllllllllllllllll11));
                }
                float llllllllllllllllllll11 = saturate(lllllllllllllllllll11) * lllllllllllllll11; 
                llllllll11 += llllllllllllllllllll11;
                if (lllllllllllllllllllll10 || (lllllllllllllllllllllllllllllll8 == 1 && llllll9 == 1 && lllllll9 == 1))
                {
                    if (llllll8 == 1 || (!lllllllllllllllllllll10))
                    {
                        llllllllllllllllllll11 *= addLight.shadowAttenuation;
                    }
                    llllll11 += llllllllllllllllllll11;
                }
                if (lllllllllllllllllllll10)
                {
                    if (lllllllllllllllll7 == 1)
                    {
                        llllllllllllll10 += saturate(llllllllllllllllllll11 * (addLight.color));
                    }
                }
                if (sign(lllllllllllllllllll11) == -1 && llllllll11 == 0)
                {
                    float lllllllllllllllllllll11 = abs(lllllllllllllllllll11);
                    llllllllll11 = min(llllllllll11, lllllllllllllllllllll11);
                }
                float llllllllllllllllllllll11 = 0;
                if (llllllllllll8 || (!lllllllllllllllllllll10 && llllllllll9))
                {
                    llllllllllllllllllllll11 = CalculateSpecularMask(lllll2, addLight.direction, lllllllllllllllllllllllllll1, llllllllllllllllllllllllllll1, lllllllllllllllllllllllllllll1, llllllllllllllllll11);
                    llllllllllllllllllllll11 *= llllllllllllllll3;
                    if (llllll8 || llllll9)
                    {
                        llllllllllllllllllllll11 *= addLight.shadowAttenuation;
                    }
                    lllllllllllllllllllllllllllllll1 += llllllllllllllllllllll11;
                    if (l11 == 1)
                    {
                        llllllllllllllllll3 += addLight.color * llllllllllllllllllllll11;
                    }
                }
                if (llllllllllllllllllllll10 && lllllllllllllllllllll10) 
                {
                    float lllllllllllllllllllllll11 = 0;
                    if (lllllllllllllllllllllll10 && (ll9 || (ll8 == llll9)))
                    {
                        lllllllll11 = llllllll11;
                        lllllllllll11 = llllllllll11;
                        lllllll11 = llllll11;
                    }
                    else
                    {
                        lllllllllllllllllllllll11 = dot(addLight.direction, lllll10);
                        if (ll9)
                        {
                            llll9 = ll8;
                        }
                        if (llll9 != 0)
                        {
                            lllllllllllllllllllllll11 = shiftLinear(lllllllllllllllllllllll11, max(-0.9999, llll9));
                        }
                        float llllllllllllllllllllllll11 = lerp(-1, lllllllllllllllllllllll11, llllllllllllllll11);
                        float lllllllllllllllllllllllll11 = saturate(llllllllllllllllllllllll11) * lllllllllllllll11;
                        lllllllll11 += lllllllllllllllllllllllll11;
                        if (llllll9 == 1 && lllllllllllllllllllllllllllllll8 == 1 && lllllll9 == 1)
                        {
                            lllllllllllllllllllllllll11 *= addLight.shadowAttenuation;
                            lllllll11 += lllllllllllllllllllllllll11;
                        }
                        if (sign(llllllllllllllllllllllll11) == -1 && lllllllll11 == 0 && lllllll9 == 1)
                        {
                            float llllllllllllllllllllllllll11 = abs(llllllllllllllllllllllll11);
                            lllllllllll11 = min(lllllllllll11, llllllllllllllllllllllllll11);
                        }
                    }
                    if (llllllllll9 == 1)
                    {
                        float lllllllllllllllllllllllllll11 = 0;
                        if (lllllllllllllllllllllll10 && llllllllllllllllllllllll10 && lllllllllll9 == 1)
                        {
                            lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1;
                            lllllllllllllllllllllllllll11 = llllllllllllllllllllll11;
                        }
                        else
                        {
                            lllllllllllllllllllllllllll11 = CalculateSpecularMask(lllll2, addLight.direction, lllllllllllllllllllllllllll1, llllllllllll9, lllllllllllll9, llllllllllllllllll11);
                            lllllllllllllllllllllllllll11 = lllllllllllllllllllllllllll11;
                            if (llllll9)
                            {
                                lllllllllllllllllllllllllll11 *= addLight.shadowAttenuation;
                            }
                            lllllllllllllllllll10 += lllllllllllllllllllllllllll11;
                        }
                        if (lllllllllllllll9 == 1)
                        {
                            llllllllllllllllllll10 += addLight.color * lllllllllllllllllllllllllll11;
                        }
                    }
                }
            }
        }
#endif
        uint pixelLightCount = GetAdditionalLightsCount();
        LIGHT_LOOP_BEGIN(pixelLightCount)
        Light addLight = GetAdditionalLight(lightIndex, inputData.positionWS, half4(1, 1, 1, 1));
#ifdef _LIGHT_LAYERS
        if (IsMatchingLightLayer(addLight.layerMask, meshRenderingLayers))
#endif
        {  
            float llllllllllllllllllllll3 = max(addLight.color.x, addLight.color.y);
            llllllllllllllllllllll3 = max(llllllllllllllllllllll3, addLight.color.z);
            half lllllllllllllll11 = addLight.distanceAttenuation * llllllllllllllllllllll3;
            float llllllllllllllll11 = smoothstep(0, 0.1/(addLight.distanceAttenuation * llllllllllllllllllllll3), addLight.distanceAttenuation * llllllllllllllllllllll3);
            float lllllllllllllllll11 = smoothstep(0, 0.01, addLight.distanceAttenuation * llllllllllllllllllllll3);
            llllllllllll11 += addLight.shadowAttenuation * lllllllllllllll11;
            float llllllllllllllllll11 = dot(addLight.direction, l10);   
            if (ll8 != 0)
            {
                llllllllllllllllll11 = shiftLinear(llllllllllllllllll11, max(-0.9999, ll8));
            }
            float lllllllllllllllllll11 = lerp(-1, llllllllllllllllll11, llllllllllllllll11);
            {
                lllllllllllll11 = min(lllllllllllll11, lerp(1, addLight.shadowAttenuation, lllllllllllllllll11));
            }
            float llllllllllllllllllll11 = saturate(lllllllllllllllllll11) * lllllllllllllll11; 
            llllllll11 += llllllllllllllllllll11;
            if (lllllllllllllllllllll10 || (lllllllllllllllllllllllllllllll8 == 1 && llllll9 == 1 && lllllll9 == 1))
            {
                if (llllll8 == 1 || (!lllllllllllllllllllll10))
                {
                    llllllllllllllllllll11 *= addLight.shadowAttenuation;
                }
                llllll11 += llllllllllllllllllll11;
            }
            if (lllllllllllllllllllll10)
            {
                if (lllllllllllllllll7 == 1)
                {
                    llllllllllllll10 += saturate(llllllllllllllllllll11 * (addLight.color));
                }
            }
            if (sign(lllllllllllllllllll11) == -1 && llllllll11 == 0)
            {
                float lllllllllllllllllllll11 = abs(lllllllllllllllllll11);
                llllllllll11 = min(llllllllll11, lllllllllllllllllllll11);
            }
            float llllllllllllllllllllll11 = 0;
            if (llllllllllll8 ||  (!lllllllllllllllllllll10 && llllllllll9))
            {
                llllllllllllllllllllll11 = CalculateSpecularMask(lllll2, addLight.direction, lllllllllllllllllllllllllll1, llllllllllllllllllllllllllll1, lllllllllllllllllllllllllllll1, llllllllllllllllll11);
                llllllllllllllllllllll11 *= llllllllllllllll3;
                if(llllll8 || llllll9)
                {
                    llllllllllllllllllllll11 *= addLight.shadowAttenuation;
                }
                lllllllllllllllllllllllllllllll1 += llllllllllllllllllllll11;
                if (l11 == 1)
                {
                    llllllllllllllllll3 += addLight.color * llllllllllllllllllllll11;
                }
            }
            if (llllllllllllllllllllll10 && lllllllllllllllllllll10) 
            {
                float lllllllllllllllllllllll11 = 0;
                if (lllllllllllllllllllllll10 && (ll9 || (ll8 == llll9) ) )
                {
                    lllllllll11 = llllllll11;
                    lllllllllll11 = llllllllll11;
                    lllllll11 = llllll11;
                }
                else
                {
                    lllllllllllllllllllllll11 = dot(addLight.direction, lllll10);
                    if (ll9)
                    {
                        llll9 = ll8;
                    }
                    if (llll9 != 0)
                    {
                        lllllllllllllllllllllll11 = shiftLinear(lllllllllllllllllllllll11, max(-0.9999, llll9));
                    }
                    float llllllllllllllllllllllll11 = lerp(-1, lllllllllllllllllllllll11, llllllllllllllll11);
                    float lllllllllllllllllllllllll11 = saturate(llllllllllllllllllllllll11) * lllllllllllllll11;
                    lllllllll11 += lllllllllllllllllllllllll11;
                    if (llllll9 == 1 && lllllllllllllllllllllllllllllll8 == 1 && lllllll9 == 1)
                    {
                        lllllllllllllllllllllllll11 *= addLight.shadowAttenuation;
                        lllllll11 += lllllllllllllllllllllllll11;
                    }
                    if (sign(llllllllllllllllllllllll11) == -1 && lllllllll11 == 0)
                    {
                        float llllllllllllllllllllllllll11 = abs(llllllllllllllllllllllll11);
                        lllllllllll11 = min(lllllllllll11, llllllllllllllllllllllllll11);
                    }
                }
                if (llllllllll9 == 1)
                {
                    float lllllllllllllllllllllllllll11 = 0;
                    if (lllllllllllllllllllllll10 && llllllllllllllllllllllll10 && lllllllllll9 == 1)
                    {
                        lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1;
                        lllllllllllllllllllllllllll11 = llllllllllllllllllllll11;
                    }
                    else
                    {
                        lllllllllllllllllllllllllll11 = CalculateSpecularMask(lllll2, addLight.direction, lllllllllllllllllllllllllll1, llllllllllll9, lllllllllllll9, llllllllllllllllll11);
                        lllllllllllllllllllllllllll11 = lllllllllllllllllllllllllll11;
                        if( llllll9)
                        {
                            lllllllllllllllllllllllllll11 *= addLight.shadowAttenuation;
                        }
                        lllllllllllllllllll10 += lllllllllllllllllllllllllll11;
                    }
                    if (lllllllllllllll9 == 1)
                    {
                        llllllllllllllllllll10 += addLight.color * lllllllllllllllllllllllllll11;
                    }
                }
            }
        }
        LIGHT_LOOP_END
#endif
        if (lllllllllllllllllllllll7 == 1 && lllllllllllllllllllllllllllllll7 == 1 && lllllllllllllllll7 == 1)
        {
            float3 lllllllllll12 = saturate(saturate(llllllllllllllllllllllllllllll1) * (mainLight.color));
            if(llllll8 == 1)
            {
                lllllllllll12 *= llll11;
            }
            llllllllllllll10 += saturate(lllllllllll12);
            llllllllllllll10 = saturate(llllllllllllll10);
            const float3 llllllllllll12 = float3(0.2126, 0.7152, 0.0722);
            float lllllllllllll12   = dot(llllllllllllll10, llllllllllll12);  
            float llllllllllllll12 = Posterize(saturate(lllllllllllll12), toonShadingData);       
            const float lllllllllllllll12 = 1e-6;        
            float llllllllllllllll12   = (lllllllllllll12 > lllllllllllllll12) ? (llllllllllllll12 / lllllllllllll12) : 0.0;
            llllllllllllll10 = llllllllllllll10 * llllllllllllllll12;
        }
        if (!lllllllllllllllllllll10)
        {
            lllllllll11 = llllllll11;
            lllllll11 = llllll11;
            lllllllllll11 = llllllllll11;
            lllllllllllllllllll10 = lllllllllllllllllllllllllllllll1 + lllllllllllllllllll10; 
            llllllllllllllllllll10 = llllllllllllllllll3;
            lllllllllllllllllllllllllllllll1 = 0;
            llllllllllllllllll3 = 0;
        }
        float lllllllllllllllll12 = saturate(llllllllllllllllllllllllllllll1);
        float llllllllllllllllll12 = saturate(llllll11);
        if (llllllllllllllllllllllll7 == 0)
        {
            if (llllllllllllllll7 == 0)
            {
                lllllllllllllllll12 = Posterize(lllllllllllllllll12, toonShadingData);
                llllllllllllllllll12 = Posterize(llllllllllllllllll12, toonShadingData);
            }
        }
        if (lllllllllllllllllllllll7 == 1 && llllll8 == 1 && (lllllllllllllllllllllllllllllll7 == 0 || (llllllllllllllllllll8 && llllllllllllllllllllllllll8==1) ) )
        {
            float lllllllllllllllllll12 = saturate(min(lllllllllllllllllllllllll10, lllllllllllll11));
            float llllllllllllllllllll12 = llll11 * saturate(llllllllllllllllllllllllllllll1) + saturate(llllllll11) * llllllllllll11;
            float lllllllllllllllllllll12 = saturate((1 - lllllllllllllllllll12) * saturate(llllllllllllllllllll12)) + lllllllllllllllllll12; 
            llll4 = lllllllllllllllllllll12;
        }
        if (llllllllllllllllllllllllllll8 == 1)
        {
            if (llllll9 == 1)
            {
                if (lllllll9 == 1)
                {
                           llllllllllllllll10 = saturate(llll11 +llllllllllll11);
                    if (lllllllllllll10 > 0)
                    {
                        lllllllllllll10 = saturate(lllllllllllll10);
                        lllllllllllll10 *= llll11;                        
                    }
                    if (lllllllll11 > 0)
                    {
                        lllllllllllll10 = saturate(lllllllllllll10);
                        lllllllllllll10 += saturate(lllllll11);
                    }
                    else
                    {
                        if (lllllllllll11 > 0)
                        {
                            lllllllllllll10 = max(lllllllllllll10, -1 * lllllllllll11 );
                        }
                    }
                }
                else
                {
                    float lllllllllllllllllll12 = min(lllllllllllllllllllllllll10, lllllllllllll11);               
                    float llllllllllllllllllll12 = llll11 * saturate(lllllllllllll10) + saturate(lllllllll11) * llllllllllll11;
                    float lllllllllllllllllllll12 = ((1 - lllllllllllllllllll12) * (llllllllllllllllllll12)) + lllllllllllllllllll12; 
                    llllllllllllllll10 = lllllllllllllllllllll12;
                }
            }         
            if (llllll9 == 0 || lllllll9 != 1) 
            {
                float lllllllllllllllllllllllll12 = lllllllllllll10;
                lllllllllllll10 = saturate(lllllllllllll10) + saturate(lllllllll11);
                if (lllllllllllll10 == 0)
                {
                    lllllllllllll10 = max(lllllllllllllllllllllllll12, -1 * lllllllllll11);
                }
            }
        }
        if (llllllllllllllllllllllllllllll1 > 0)
        {
            llllllllllllllllllllllllllllll1 = saturate(lllllllllllllllll12);
            if(llllll8 == 1)
            {
                llllllllllllllllllllllllllllll1 *= llll11;
            }
        }
        if (llllllll11 > 0)
        {
            llllllllllllllllllllllllllllll1 = saturate(llllllllllllllllllllllllllllll1);
            llllllllllllllllllllllllllllll1 += saturate(llllllllllllllllll12);
        }
        else
        {
            if (llllllllll11 > 0)
            {
                llllllllllllllllllllllllllllll1 = max(llllllllllllllllllllllllllllll1, -1 * llllllllll11);
            }
        }
        if (llllllllllllllllllllllllllllll1 < 0)
        {
        }
        else
        {
            if (llllllllllllllllllllllll7 == 0 && llllllllllllllll7 == 1)
            {
                llllllllllllllllllllllllllllll1 = Posterize(saturate(llllllllllllllllllllllllllllll1), toonShadingData);
            }
        }
    }
#else 
    UnityLight lllllllllllllllllllllllllll9 = gi.light;
    llllllllllllllllllllllllllllll1 = dot(lllllllllllllllllllllllllll9.dir, lll10);
    if (ll8 != 0)
    {
        llllllllllllllllllllllllllllll1 = shiftLinear(llllllllllllllllllllllllllllll1, max(-0.9999, ll8));
    }
    if (ll9 == 0)
    {
        lllllllllllll10 = dot(lllllllllllllllllllllllllll9.dir, lllll10);
        if (llll9 != 0)
        {
            lllllllllllll10 = shiftLinear(lllllllllllll10, max(-0.9999, llll9));
        }
    }
    else
    {
        lllllllllllll10 = llllllllllllllllllllllllllllll1;
    }
#if !_PASSFORWARDADD    
    if (llllllllllllllllllllllllllllll1 > 0)
    {
        llll4 = giInput.atten;
    }
    else
    {
        llll4 = 1;
    }
    if (llllll9 == 1 && lllllllllllllllllllllllllllllll8 == 1 && lllllll9 == 1)
    {
        lllllllllllll10 *= llll4;
    }
    llllllllllllllll10 = llll4;
        #else    
    llll4 = 0;    
    llllllllllllllllllll8 = 0;    
    llllllllllllllllllllllllllll8 = 0;    
    lllllllllllllllll9 = 0;
    lllllllllllllllllllllllllllllll8 = 0;
    llllll9 = 0;
    stylingDataShading.color = 0;
    stylingDataSpecular.color = half4(gi.light.color,1);
#endif
#endif
    float lllllllllllllllllllllllllllll12 = llll4;
    float llllllllllllllllllllllllllllll12 = 0;
    float4 lllllllllllllllllllllllllllllll12 = 0;
    float3 lllllllllllllllllllllllllll3;
    if (lllllllllllllllllllllllllll8 == 0)
    {
        lllllllllllllllllllllllllll3 = llllllllllllllllllllllllll9;
    }
    else
    {
    #if _URP 
        lllllllllllllllllllllllllll3 = inputData.normalWS;
    #else
        lllllllllllllllllllllllllll3 = o.Normal;
    #endif
    }
    float lllllllllllllllllll12 = 0;      
    if (lllllllllllllllllllll7 == 0) 
    {
        lllllllllllllllllllllllllllll12 = llll4;
        if (lllllllllllllllllllllll7 == 1)
        {
            if (llllllllllllllllllllllll7 == 0)
            {
                if (lllllllllllllllllllllllllllllll7 == 1)
                {
                    float4 llllllllllllllllllllllllllllll12 = saturate(llllllllllllllllllllllllllllll1);
                    #if _URP
                        if (lllllllllllllllll7 == 1)
                        {
                            lllllllllllllllllllllllllllll6 *= float4(llllllllllllll10, 1); 
                        }
                    #else
                        llllllllllllllllllllllllllllll12 = Posterize(llllllllllllllllllllllllllllll12.r, toonShadingData);
                    #endif
                    lllllllllllllllllllllllllllll6 = lerp(lerp(l8, lllllllllllllllllllllllllllll6, 1 - l8.a), lllllllllllllllllllllllllllll6, llllllllllllllllllllllllllllll12);
    #if !_URP
                    if (llllll8 == 1)
                    {
                        float3 lllllllllllllllllllllllll13 = lerp(l8.rgb, llllllllllllllllllllllllllllll9.rgb, 1 - l8.a);
                        lllllllllllllllllllllllllllll6 = float4(lerp(lllllllllllllllllllllllll13, lllllllllllllllllllllllllllll6.rgb, saturate(llll4)), llllllllllllllllllllllllllllll9.a);
                    }
    #endif
                }
            }
            else
            {
                float llllllllllllllllllllllllll13 = min(0.95, llllllllllllllllllllllllllllll1); 
                if (llllllllllllllllllllllllllll7 == 1 && lllllllllllllllllllllllllllllll7 == 0 && llllllllllllllllllllllllllllll1 < 0)
                {
                    llllllllllllllllllllllllll13 = 0;
                }
                llllllllllllllllllllllllll13 = (llllllllllllllllllllllllll13 + 1) / 2;
                float4 lllllllllllllllllllllllllll13 = float4(0, 0, 0, 0);
                float llllllllllllllllllllllllllll13 = llllllllllllllllllllllllllll9.z;
                float lllllllllllllllllllllllllllll13 = llllllllllllllllllllllllll13 * (llllllllllllllllllllllllllll13 - 1);
                float2 llllllllllllllllllllllllllllll13 = (lllllllllllllllllllllllllllll13 + 0.5) * llllllllllllllllllllllllllll9.xy;
                lllllllllllllllllllllllllll13 = tex2D(llllllllllllllllllllllllll7, llllllllllllllllllllllllllllll13);
                DoBlending(lllllllllllllllllllllllllllll6, llllllllllllllllllllllllllllll7, lllllllllllllllllllllllllllll7, lllllllllllllllllllllllllll13);
            }
            if (llllll8 == 0 && (llllllllllllllllllllllllllll8 == 0 || llllll9 == 0))
            {
                llll4 = 1;
            }
            if (lllllllllllllllllllllllllllllll7 == 1 && llllllllllllllllllllllll7 == 0)
            {
                if (llllllllllllllllllllllllllllll1 < 0.0)
                {
                    lllllllllllllllllllllllllllll6 = lllll8;
                    llll8 = 1 - llll8;
                    float llll14 = llll8 * lll8;
                    float lllll14 = smoothstep(-llll14 + 0.01, -lll8, llllllllllllllllllllllllllllll1);
                    float3 lllllllllllllllllllllllll13 = lerp(l8.rgb, llllllllllllllllllllllllllllll9.rgb, 1 - l8.a);
                    float3 lllllll14 = lerp(lllll8.rgb, llllllllllllllllllllllllllllll9.rgb, 1 - lllll8.a);
                    lllllllllllllllllllllllllllll6 = float4(lerp(lllllllllllllllllllllllll13, lllllll14, lllll14), llllllllllllllllllllllllllllll9.a);
                }
            }
            if (lllllllllllllllllllllllllllllll7 == 0 && llllllllllllllllllllllll7 == 0 && llllll8 == 1)
            {
                float3 lllllllllllllllllllllllll13 = lerp(l8.rgb, llllllllllllllllllllllllllllll9.rgb, 1 - l8.a);
                lllllllllllllllllllllllllllll6 = float4(lerp(lllllllllllllllllllllllll13, lllllllllllllllllllllllllllll6.rgb, saturate(llll4)), llllllllllllllllllllllllllllll9.a);
            }
        }
#if _ENABLE_SPECULAR || !_USE_OPTIMIZATION_DEFINES
        if (llllllllllll8 == 1)
        {
    #if _URP
    #else
            lllllllllllllllllllllllllllllll1 = CalculateSpecularMask(lllll2, lllllllllllllllllllllllllll9.dir, lllllllllllllllllllllllllll1, lllllllllllllll8, llllllllllllllll8, llllllllllllllllllllllllllllll1);
            lllllllllllllllllllllllllllllll1 *= lllllllllllllllll8;
            if (llllll8 == 1)
            {
                lllllllllllllllllllllllllllllll1 *= llll4;
            }
    #endif
#if _USE_OPTIMIZATION_DEFINES
#ifdef _SPECULAR_BLENDING
            lllllllllllll8 = _SPECULAR_BLENDING;
#endif
#endif
            half4 lllllllll14;
            {
                lllllllll14 = llllllllllllll8;
            }
            DoBlending(lllllllllllllllllllllllllllll6, lllllllllllllllllllllllllllllll1, lllllllllllll8, lllllllll14);
        }
#endif
    #if _URP
    lllllllllllllllllllllllllllll6 += half4(surface.emission, 0);
    #else
    lllllllllllllllllllllllllllll6 += half4(o.Emission, 0);
    #endif
    }
    else 
    {
        ToonShadingData toonShadingData;
        toonShadingData.enableToonShading = lllllllllllllllllllllll7;
#if _URP
        toonShadingData.normalWS = inputData.normalWS;
#endif
        toonShadingData.normalWSNoMap = llllllllllllllllllllllllll9;
        toonShadingData.cellTransitionSmoothness = lllllllllllllll7;
        toonShadingData.numberOfCells = lllllllllllllllllllllllllllllll9;
        toonShadingData.specularEdgeSmoothness = llllllllllllllll8;
        toonShadingData.shadingAffectByNormalMap = lllllllllll8;
        toonShadingData.specularAffectedByNormalMap = llllllllllllllllll8;
#if _USE_OPTIMIZATION_DEFINES
#if _ENABLE_TOON_SHADING 
                toonShadingData.enableToonShading = 1;
#else
                toonShadingData.enableToonShading = 0;
#endif
#endif
#if _SHADING_BLINNPHONG       
        if (llllllllllllllllllllll7 == 0) 
        {
#if _URP
        #if UNITY_VERSION >= 202120
            lllllllllllllllllllllllllllll6 = UniversalFragmentBlinnPhong(inputData, surface.albedo, half4(surface.specular, surface.smoothness), surface.smoothness, surface.emission, surface.alpha,llllllll7, toonShadingData);
        #else
            lllllllllllllllllllllllllllll6 = UniversalFragmentBlinnPhong(inputData, surface.albedo, half4(surface.specular, surface.smoothness), surface.smoothness, surface.emission, surface.alpha, toonShadingData);
        #endif
#else
#endif
        }
#endif        
#if _SHADING_PBR
        if (llllllllllllllllllllll7 == 1) 
        {      
#if _URP
            lllllllllllllllllllllllllllll6 = UniversalFragmentPBR(inputData, surface, toonShadingData);
#else
#if !_PASSFORWARDADD
    #if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
    #else
        LightingStandard_GI_Toon(o, giInput, gi, toonShadingData);
        #if defined(_OVERRIDE_BAKEDGI)
            gi.indirect.diffuse = l.DiffuseGI;
            gi.indirect.specular = l.SpecularGI;
        #endif
        lllllllllllllllllllllllllllll6 = LightingStandard_Toon (o, d.worldSpaceViewDir, gi, toonShadingData);
        lllllllllllllllllllllllllllll6 += half4(o.Emission, 0);
    #endif     
#else
    #if _USESPECULAR
#elif _BDRF3 || _SIMPLELIT
#else
                  lllllllllllllllllllllllllllll6 = LightingStandard_Toon (o, d.worldSpaceViewDir, gi, toonShadingData);
#endif
#endif
#endif
        }
#endif
    }
    float lllll4 = 0;
    if (lllllllllllllllllllllll7 == 1)
    {
    #if _URP
        Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
        float lllllllllll14 = dot(mainLight.direction, lllllllllllllllllllllllllll3);
        float llllllllllll14 = mainLight.shadowAttenuation;
    #else
        float llllllllllllllllllllllllllllll1 = dot(lllllllllllllllllllllllllll9.dir, lllllllllllllllllllllllllll3);
    #endif
    #if _ENABLE_RIM || !_USE_OPTIMIZATION_DEFINES
        #if !_USE_OPTIMIZATION_DEFINES
        if (llllllllllllllllllll8 == 1)
        #endif
        {
        #if _URP         
            lllll4 = CalculateRimMask(lllllllllllllllllllllllllll3, lllllllllllllllllllllllllll1, lllllllllllllllllllllll8, llllllllllllllllllllllll8, lllllllllll14, llllllllllllllllllllllllll8, llllll8, lllllllllllllllllllllllllllllll7, llllllllllll14);
        #else
            lllll4 = CalculateRimMask(lllllllllllllllllllllllllll3, lllllllllllllllllllllllllll1, lllllllllllllllllllllll8, llllllllllllllllllllllll8, llllllllllllllllllllllllllllll1, llllllllllllllllllllllllll8, llllll8, lllllllllllllllllllllllllllllll7, llll4);
        #endif   
            lllll4 *= lllllllllllllllllllllllll8;
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _RIM_BLENDING
                        lllllllllllllllllllll8 = _RIM_BLENDING;
            #endif
        #endif   
            lllll4 = saturate(lllll4);
            DoBlending(lllllllllllllllllllllllllllll6, lllll4, lllllllllllllllllllll8, llllllllllllllllllllll8);
        }
    #endif
    }
#if _ENABLE_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
    if (llllllllllllllllllllllllllll8 == 1)
    #endif
    {
#ifdef _EMISSION 
    #if _URP
        float3 llllllllllllll14 = surface.emission;
    #else
        float3 llllllllllllll14 = o.Emission;
    #endif
        float lllllllllllllllll14 = max(max(llllllllllllll14.r, llllllllllllll14.g), llllllllllllll14.b);
#endif
#if !_URP
        if (llllllllll9 == 1)
        {
            if (llllllllllll8 == 0 || lllllllllll9 == 0) 
            {
                float llllllllllllllllll14 = saturate(llllllllllllllllllllllllllllll1);
                lllllllllllllllllll10 = CalculateSpecularMask(lllll10, lllllllllllllllllllllllllll9.dir, lllllllllllllllllllllllllll1, llllllllllll9, lllllllllllll9, llllllllllllllllll14);
                lllllllllllllllllll10 = saturate(lllllllllllllllllll10);
                lllllllllllllllllll10 *= lllllllllllllllllllllllllllll12;
            }
            else
            {
                lllllllllllllllllll10 = saturate(lllllllllllllllllllllllllllllll1);
            }
        }
#endif
        if (llllllllllllll9 == 1)
        {
            lllllllllllll10 = 1 - lllllllllllll10 - lllllllllllllllllll10 * 10;
            lllllllllllll10 = 1 - lllllllllllll10;
            lllllllllllllllllllllllllllll12 = 1 - ((1 - lllllllllllllllllllllllllllll12) - lllllllllllllllllll10 * 10);
        }
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SHADING_STYLING_DRAWSPACE
        uvSpaceDataShading.drawSpace = _SHADING_STYLING_DRAWSPACE;
            #endif
            #ifdef _SHADING_STYLING_COORDINATESYSTEM
        uvSpaceDataShading.coordinateSystem = _SHADING_STYLING_COORDINATESYSTEM;
            #endif
        #endif
    #if _URP
        float2 lllllllllllllllllll14 = ConvertToDrawSpace(inputData, lllllllll1, uvSpaceDataShading, llllllllllllllllllllllllllll0, uvSets);
    #else
        float2 lllllllllllllllllll14 = ConvertToDrawSpace(d.worldSpacePosition, d.worldSpaceNormal, lllllllll1, uvSpaceDataShading, llllllllllllllllllllllllllll0, uvSets);
    #endif
        float llllllllllllllllllllll14 = stylingDataShading.density;
        float llllllllllllllllllllllll5 = stylingDataShading.size;
        float llllllllllllllllllllllll14 = 1;
#if _ENABLE_SHADING_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (lllllllllllllllllllllllllllllll8 != 0)
    #endif        
        {
            float lllllllllllllllllllllllll14 = 0;            
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SHADING_STYLING_BLENDING
                    positionAndBlendingDataShading.blending = _SHADING_STYLING_BLENDING;
            #endif                   
            #ifdef _SHADING_STYLE
                stylingDataShading.style = _SHADING_STYLE;
            #endif
            #if _SHADING_STYLING_RANDOMIZER
                stylingRandomDataShading.enableRandomizer = 1;
            #else
                stylingRandomDataShading.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataShading;
    #if _USE_OPTIMIZATION_DEFINES
        #ifdef _SHADING_STYLING_RANDOMIZER_PERLIN
            requiredNoiseDataShading.perlinNoise = 1;
        #else
            requiredNoiseDataShading.perlinNoise = 0;
        #endif
        #ifdef _SHADING_STYLING_RANDOMIZER_PERLIN_FLOORED
            requiredNoiseDataShading.perlinNoiseFloored = 1;
        #else
            requiredNoiseDataShading.perlinNoiseFloored = 0;
        #endif         
        #ifdef _SHADING_STYLING_RANDOMIZER_WHITE
            requiredNoiseDataShading.whiteNoise = 1;
        #else
            requiredNoiseDataShading.whiteNoise = 0;
        #endif
        #ifdef _SHADING_STYLING_RANDOMIZER_WHITE_FLOORED
            requiredNoiseDataShading.whiteNoiseFloored = 1;
        #else
            requiredNoiseDataShading.whiteNoiseFloored = 0;
        #endif            
    #else            
            requiredNoiseDataShading.perlinNoise = 1;
            requiredNoiseDataShading.perlinNoiseFloored = 1;
            requiredNoiseDataShading.whiteNoise = 1;
            requiredNoiseDataShading.whiteNoiseFloored = 1;
    #endif
            float llllllllllllllllllllllllll14 = (lllllllllllll10);
            if (llllll9 == 1 && lllllll9 == 1)
            {
                stylingDataShading.opacityFalloff *= llllllllllllllll10;
                stylingDataShading.sizeFalloff *= llllllllllllllll10;
            }
            if (positionAndBlendingDataShading.isInverted == 1)
            {
                llllllllllllllllllllllllll14 = 1 - saturate(llllllllllllllllllllllllll14);
            }
            if (stylingDataShading.style == 0) 
            {                             
                float llllllllllllllllllllll14 = stylingDataShading.density;
                float llllllllllllllllllllllll5 = stylingDataShading.size;
                llllllllllllllllllllllll5 = stylingDataShading.size / 2;
                if (ll9 == 0)
                {
                    lllllllllllllllllllllllllllllll9 = lll9;
                }
                else
                {
                    lllllllllllllllllllllllllllllll9 = llllllllllllll7;
                }
            #if _USE_OPTIMIZATION_DEFINES            
                #ifdef _SHADING_STYLING_NUMBER_OF_CELLS_HATCHING
                        lllllllllllllllllllllllllllllll9 = _SHADING_STYLING_NUMBER_OF_CELLS_HATCHING;
                #endif                            
            #endif
                float lllllllllllllllllllllllllllll14 = (1. / lllllllllllllllllllllllllllllll9) * lllll9;
                int llllllllllllllllllllllllllllll14 = ceil((max(llllllllllllllllllllllllll14 - lllllllllllllllllllllllllllll14, 0)) * lllllllllllllllllllllllllllllll9);
                llllllllllllllllllllllllllllll14 = lllllllllllllllllllllllllllllll9 - llllllllllllllllllllllllllllll14;
                float lllllllllllllllllllllllllllllll14 = stylingDataShading.rotation;
                float l15 = radians(lllllllllllllllllllllllllllllll14);
                float ll15 = stylingDataShading.rotationBetweenCells;
                float lll15 = radians(ll15);
                float2 llll15; 
                NoiseSampleData noiseSampleData; 
                llllllllllllllllllllllll14 = 1;
                float lllllllllllllllll1 = 0;
    #if _USE_OPTIMIZATION_DEFINES            
                [unroll(lllllllllllllllllllllllllllllll9)]
    #else
                [unroll(15)]
    #endif
                    for (int i = 1; i <= llllllllllllllllllllllllllllll14; i++)
                    {
                        llllllllllllllllllllllll5 = stylingDataShading.size / 2;
                        float llllll15 = i - 1;
                        float lll5 = l15 + lll15 * llllll15;
                        lllllllllllllllllll14 += lllllllllllllllll1; 
                        llll15 = RotateUVRadians(lllllllllllllllllll14, lll5);
                        noiseSampleData = SampleNoiseData(llll15, stylingDataShading, stylingRandomDataShading, requiredNoiseDataShading, lllllllll5, llllllllll5);
                        lllllllllllllllll1 += (float) stylingDataShading.density;
                        float llllllll15 = llll15.x;
                        llllllll15 *= stylingDataShading.density;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            llllllll15 += noiseSampleData.perlinNoise * stylingRandomDataShading.noiseIntensity;
                            float llllllllllllllllllllllllll5 = 0;
                            if (stylingRandomDataShading.thicknessRandomMode == 0)
                            {
                                llllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
                            }
                            else if (stylingRandomDataShading.thicknessRandomMode == 1) 
                            {
                                llllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
                            }
                            else 
                            {
                                llllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
                            }
                            float lllllllllllllllllllllllllll5 = remap(0, 1, 0.0, llllllllllllllllllllllll5, llllllllllllllllllllllllll5 * stylingRandomDataShading.thicknesshRandomIntensity);
                            llllllllllllllllllllllll5 -= lllllllllllllllllllllllllll5;
                            float llllllllllllllllllllllllllll5 = 0;
                            if (stylingRandomDataShading.spacingRandomMode == 0)
                            {
                                llllllllllllllllllllllllllll5 = noiseSampleData.whiteNoise;
                            }
                            else if (stylingRandomDataShading.spacingRandomMode == 1) 
                            {
                                llllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored;
                            }
                            else 
                            {
                                llllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored) + noiseSampleData.whiteNoise) / 2;
                            }
                            float lllllllllllllllllllllllllllll5 = remap(0, 1, -0.5 + llllllllllllllllllllllll5, 0.5 - llllllllllllllllllllllll5, llllllllllllllllllllllllllll5);
                            llllllll15 += lllllllllllllllllllllllllllll5 * stylingRandomDataShading.spacingRandomIntensity * saturate(1 - stylingRandomDataShading.noiseIntensity); 
                        }
                        llllllll15 = abs(frac(llllllll15) - 0.5);
                        float lllllllllllll15 = (float) (lllllllllllllllllllllllllllllll9 - i) / lllllllllllllllllllllllllllllll9;
                        float llllllllllllll15 = remap(0, 1, 0, lllllllllllllllllllllllllllll14, lllll9);
                        float llllllllllllllllllllllllllllll5;
                        float l6;
                        float lllllllllllllllll15 = 0;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            float lllllllllllllllllllllllllllllll5 = 0;
                            if (stylingRandomDataShading.lengthRandomMode == 0)
                            {
                                lllllllllllllllllllllllllllllll5 = noiseSampleData.whiteNoise * saturate(1 - stylingRandomDataShading.noiseIntensity);
                            }
                            else if (stylingRandomDataShading.lengthRandomMode == 1)
                            {
                                lllllllllllllllllllllllllllllll5 = noiseSampleData.perlinNoiseFloored; 
                            }
                            else
                            {
                                lllllllllllllllllllllllllllllll5 = ((noiseSampleData.perlinNoiseFloored + (noiseSampleData.whiteNoise * saturate(1 - stylingRandomDataShading.noiseIntensity))) / 2); 
                            }
                            l6 = lllllllllllllllllllllllllllllll5 * stylingRandomDataShading.lengthRandomIntensity;
                            lllllllllllllllll15 = remap(0, 1, 0, lllllllllllll15 + llllllllllllll15, l6);
                        }
                        llllllllllllllllllllllllllllll5 = remap(0, lllllllllllll15 + llllllllllllll15 - lllllllllllllllll15, 0, 1, llllllllllllllllllllllllll14);
                        if (i == lllllllllllllllllllllllllllllll9 && sign(llllllllllllllllllllllllll14) == 1)
                        {
                            float lllllllllllllllll15 = 0;
                            if (stylingRandomDataShading.enableRandomizer == 1)
                            {
                                lllllllllllllllll15 = remap(0, 1, 0, 1 - lllllllllllllllllllllllllllll14, l6);
                            }
                            llllllllllllllllllllllllllllll5 = remap(0, lllllllllllllllllllllllllllll14, 1 - lllllllllllllllllllllllllllll14 + lllllllllllllllll15, 1 + lllllllllllllllll15, llllllllllllllllllllllllll14);
                        }
                        if (i == lllllllllllllllllllllllllllllll9 && sign(llllllllllllllllllllllllll14) == -1)
                        {
                            float llllllllllllllllllll15 = (float) 1. / lllllllllllllllllllllllllllllll9;
                            llllllllllllll15 = remap(0, 1, 0, llllllllllllllllllll15, lllll9);
                            float lllllllllllllllll15 = 0;
                            if (stylingRandomDataShading.enableRandomizer == 1)
                            {
                                lllllllllllllllll15 = remap(0, 1, 0, 1 - llllllllllllll15, l6);
                            }
                            llllllllllllllllllllllllllllll5 = remap(0, -1, 1 - llllllllllllll15 + lllllllllllllllll15, 0, llllllllllllllllllllllllll14);
                        }
                        float ll6 = smoothstep(1 - stylingDataShading.sizeFalloff, 1, llllllllllllllllllllllllllllll5);
                        if (lllllllllllllllllllllllllllll12 <= 0 && llllllllllllllllllllllllll14 > 0)
                        {
                        }
                        ll6 = max(llllllllllllllllllllllll5 - ll6, 0);
                        float lll6;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            float llll6 = 0;
                            if (stylingRandomDataShading.hardnessRandomMode == 0) 
                            {
                                llll6 = noiseSampleData.whiteNoise;
                            }
                            else if (stylingRandomDataShading.hardnessRandomMode == 1) 
                            {
                                llll6 = noiseSampleData.perlinNoiseFloored * 5;
                            }
                            else
                            {
                                llll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
                            }
                            lll6 = remap(0, 1, 0, ll6, min(saturate(stylingDataShading.hardness - llll6 * stylingRandomDataShading.hardnessRandomIntensity), stylingDataShading.hardness));
                        }
                        else
                        {
                            lll6 = remap(0, 1, 0, ll6, stylingDataShading.hardness);
                        }
                        if (ll6 != 0)
                        {
                            float lllll6 = 0;
                            if (llllllllllllllllllllll5)
                            {
                                lllll6 = fwidth(llllllll15); 
                            }
                            if (ll6 == llllllllllllllllllllllll5 && stylingDataShading.size == 1)
                            {
                                lllll6 = 0;
                            }
                            if (lll6 - lllll6 < 0)
                            {
                                lllll6 = 0;
                            }
                            llllllll15 = smoothstep(lll6 - lllll6, ll6 + lllll6, llllllll15);
                        }
                        else
                        {
                            llllllll15 = 1; 
                        }
                        llllllll15 = 1 - llllllll15;
                        if (stylingRandomDataShading.enableRandomizer == 1)
                        {
                            float llllll6;
                            if (stylingRandomDataShading.opacityRandomMode == 0) 
                            {
                                llllll6 = noiseSampleData.whiteNoise;
                            }
                            else if (stylingRandomDataShading.opacityRandomMode == 1) 
                            {
                                llllll6 = noiseSampleData.perlinNoiseFloored * 5;
                            }
                            else 
                            {
                                llllll6 = ((noiseSampleData.perlinNoiseFloored + noiseSampleData.whiteNoise) / 2) * 5;
                            }
                            llllllll15 = saturate(llllllll15 - (llllll6 * stylingRandomDataShading.opacityRandomIntensity));
                        }
                        float lllllll6 = smoothstep(saturate(min(1 - stylingDataShading.opacityFalloff, 1)), 1, llllllllllllllllllllllllllllll5);
                        llllllll15 *= 1 - lllllll6;
                        llllllll15 = 1 - llllllll15;
                        llllllllllllllllllllllll14 = min(llllllll15, llllllllllllllllllllllll14);
                    }
                llllllllllllllllllllllll14 = 1 - llllllllllllllllllllllll14;
                llllllllllllllllllllllll14 *= stylingDataShading.opacity;
                llllllllllllllllllllllll14 = 1 - llllllllllllllllllllllll14;
                lllllllllllllllllllllllll14 = llllllllllllllllllllllll14;             
            }
            else if (stylingDataShading.style == 1) 
            {               
                float2 lllllllllll6 = lllllllllllllllllll14;
                float2 lllllllllllllllllllllllllllllll4 = RotateUV(lllllllllll6, stylingDataShading.rotation);
                NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllllllllllllllllll4, stylingDataShading, stylingRandomDataShading, requiredNoiseDataShading, lllllllll5, llllllllll5);
                if (false)
                {
                } 
                float llllllllllllllllllllllllllllll15 = 1 - llllllllllllllllllllllllll14;
                float llllllllllllllllllllllllll6 = Halftones(llllllllllllllllllllllllllllll15, lllllllllllllllllllllllllllllll4, stylingDataShading, stylingRandomDataShading, noiseSampleData);
                lllllllllllllllllllllllll14 = llllllllllllllllllllllllll6;
            }
            if (false)
            {
            }
        #ifdef _EMISSION
            lllllllllllllllllllllllll14 = 1 - lllllllllllllllllllllllll14;
            lllllllllllllllllllllllll14 = saturate(lllllllllllllllllllllllll14 - lllllllllllllllll14);
            lllllllllllllllllllllllll14 = 1 - lllllllllllllllllllllllll14;
        #endif
            #if _USE_OPTIMIZATION_DEFINES
                #if _ENABLE_STYLING_DISTANCEFADE
                     generalStylingData.enableDistanceFade = 1;
                #else
                    generalStylingData.enableDistanceFade = 0;
                #endif
            #endif
            if (generalStylingData.enableDistanceFade == 1)
            {
                float l16 = llllllllllllllllllllllllll14;
                if (stylingDataShading.style == 0)
                {
                    int lllllllllllllllllllllllllllllll9;
                    if (ll9 == 0)
                    {
                        lllllllllllllllllllllllllllllll9 = lll9;
                    }
                    else
                    {
                        lllllllllllllllllllllllllllllll9 = llllllllllllll7;
                    }
                    float lllllllllllllllllllllllllllll14 = (1. / lllllllllllllllllllllllllllllll9) * lllll9;
                    float llllllllllllll15 = remap(0, 1, 0, lllllllllllllllllllllllllllll14, lllll9);
                    l16 -= -1 + ((lllllllllllllllllllllllllllllll9 - 1.) / lllllllllllllllllllllllllllllll9) + llllllllllllll15;
                }
                float lllll16 = distance(_WorldSpaceCameraPos, d.worldSpacePosition);
                float llllll16 = max(l16, 1 - stylingDataShading.opacityFalloff);
                llllll16 = remap(1 - stylingDataShading.opacityFalloff, 1, 0, 1, llllll16);
                float lllllll16 = max(l16, 1 - stylingDataShading.sizeFalloff);
                lllllll16 = remap(1 - stylingDataShading.sizeFalloff, 1, 0, 1, lllllll16);
                float llllllll16 = lerp(0.0, 1, saturate(1 - stylingDataShading.size)); 
                if (generalStylingData.adjustDistanceFadeValue == 1)
                {
                    llllllll16 = generalStylingData.distanceFadeValue;
                }
                lllllll16 = max(llllllll16, lllllll16 * 2);
                llllll16 = max(llllllll16, llllll16);
                float lllllllll16 = max(lllllll16, llllll16);
                lllllllll16 = saturate(lllllllll16);
                lllllllllllllllllllllllll14 = lerp(lllllllllllllllllllllllll14, lllllllll16, saturate(((lllll16 - generalStylingData.distanceFadeStartDistance) / generalStylingData.distanceFadeFalloff)));
            }
            if (positionAndBlendingDataShading.isInverted == 1)
            {
                lllllllllllllllllllllllll14 = 1 - lllllllllllllllllllllllll14;
            }
            DoBlending(lllllllllllllllllllllllllllll6, 1 - lllllllllllllllllllllllll14, positionAndBlendingDataShading.blending, stylingDataShading.color);
            if (false)
            {                
            }
            if (false)
            {
            }
        }
#endif
#if (_ENABLE_CASTSHADOWS_STYLING && _STYLING_CASTSHADOWS_SYNC_WITH_OTHER_STYLING != 1) || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (llllll9 && lllllll9 != 1)   
    #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _CASTSHADOWS_STYLING_BLENDING
                positionAndBlendingDataCastShadows.blending = _CASTSHADOWS_STYLING_BLENDING;
            #endif
            #ifdef _CASTSHADOWS_STYLING_DRAWSPACE
                uvSpaceDataCastShadows.drawSpace = _CASTSHADOWS_STYLING_DRAWSPACE;
            #endif
            #ifdef _CASTSHADOWS_STYLING_COORDINATESYSTEM
                uvSpaceDataCastShadows.coordinateSystem = _CASTSHADOWS_STYLING_COORDINATESYSTEM;
            #endif            
            #ifdef _CASTSHADOWS_STYLE
                stylingDataCastShadows.style = _CASTSHADOWS_STYLE;
            #endif
            #if _CASTSHADOWS_STYLING_RANDOMIZER
                stylingRandomDataCastShadows.enableRandomizer = 1;
            #else
                stylingRandomDataCastShadows.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataCastShadows;
    #if _USE_OPTIMIZATION_DEFINES
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_PERLIN
            requiredNoiseDataCastShadows.perlinNoise = 1;
        #else
            requiredNoiseDataCastShadows.perlinNoise = 0;
        #endif
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_PERLIN_FLOORED
            requiredNoiseDataCastShadows.perlinNoiseFloored = 1;
        #else
            requiredNoiseDataCastShadows.perlinNoiseFloored = 0;
        #endif         
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_WHITE
            requiredNoiseDataCastShadows.whiteNoise = 1;
        #else
            requiredNoiseDataCastShadows.whiteNoise = 0;
        #endif
        #ifdef _CASTSHADOWS_STYLING_RANDOMIZER_WHITE_FLOORED
            requiredNoiseDataCastShadows.whiteNoiseFloored = 1;
        #else
            requiredNoiseDataCastShadows.whiteNoiseFloored = 0;
        #endif            
        #else            
            requiredNoiseDataCastShadows.perlinNoise = 1;
            requiredNoiseDataCastShadows.perlinNoiseFloored = 1;
            requiredNoiseDataCastShadows.whiteNoise = 1;
            requiredNoiseDataCastShadows.whiteNoiseFloored = 1;
        #endif
    #if _URP
            float2 llllllllll16 = ConvertToDrawSpace(inputData, lllllllll1, uvSpaceDataCastShadows, llllllllllllllllllllllllllll0, uvSets);           
    #else
            float2 llllllllll16 = ConvertToDrawSpace(d.worldSpacePosition, d.worldSpaceNormal, lllllllll1, uvSpaceDataCastShadows, llllllllllllllllllllllllllll0, uvSets);
    #endif
        #ifdef _EMISSION
            llllllllllllllll10 = 1 - llllllllllllllll10;
            llllllllllllllll10 = saturate(llllllllllllllll10 - lllllllllllllllll14);
            llllllllllllllll10 = 1 - llllllllllllllll10;
        #endif
            lllllllllllllllllllllllllllll12 = llllllllllllllll10;
            float lllllllllllllllllllllllll14 = 0;
            if (stylingDataCastShadows.style == 0) 
            {
                float lllllllllllll16 = stylingDataCastShadows.rotation;
                float llllllllllllll16 = radians(lllllllllllll16);
                float lllllllllllllll16 = stylingDataCastShadows.rotationBetweenCells;
                float llllllllllllllll16 = radians(lllllllllllllll16);
                float lllllllllllllllll16 = lllllllll9;
                lllllllllllllllll16 = min(lllllllllllllllll16, 0.99);
                float llllllllllllllllll16 = 1;
                float lllllllllllllllllllllllllllllll9 = llllllll9;
            #if _USE_OPTIMIZATION_DEFINES            
                #ifdef _CASTSHADOWS_STYLING_NUMBER_OF_CELLS_HATCHING
                        lllllllllllllllllllllllllllllll9 = _CASTSHADOWS_STYLING_NUMBER_OF_CELLS_HATCHING;
                #endif                           
                [unroll(lllllllllllllllllllllllllllllll9)]
            #else
                [unroll(15)]
            #endif
                for (int j = 1; j <= lllllllllllllllllllllllllllllll9; j++)
                {
                    llllllllllllllll10 = min(j / lllllllllllllllllllllllllllllll9, lllllllllllllllllllllllllllll12);
                    if (lllllllllllllllllllllllllllllll9 != 1)
                    {
                        float llll7 = 0;
                        if (lllllllllllllllllllllllllllllll9 <= 1)
                        {
                            llll7 = 0.0;
                        }
                        else
                        {
                            float lllllllllllllllllllll16 = (float) j - 1;
                            float llllllllllllllllllllll16 = (float) (lllllllllllllllllllllllllllllll9 - 1);
                            float lllllllllllllllllllllll16 = lllllllllllllllllllll16 / llllllllllllllllllllll16;
                            llll7 = lerp(1.0, lllllllllllllllllllllll16, lllllllllllllllll16);
                        }
                        float llllllllllllllllllllllll16 = min(llll7, lllllllllllllllllllllllllllll12); 
                        llllllllllllllllllllllll16 = remap(0, llll7, 0, 1, lllllllllllllllllllllllllllll12);
                        llllllllllllllll10 = llllllllllllllllllllllll16;
                        llllllllllllllll10 = max(llll4, lllllllllllllllllllllllllllll12);
                    }
                    else
                    {
                        llllllllllllllll10 = lllllllllllllllllllllllllllll12;
                    }
                    float llllll15 = j - 1;
                    float lll5 = llllllllllllll16 + llllllllllllllll16 * llllll15;
                    float2 llll15 = RotateUVRadians(llllllllll16, lll5);
                    llll15.x += (j - 1) / (float) lllllllllllllllllllllllllllllll9 * stylingDataCastShadows.density; 
                    NoiseSampleData noiseSampleData = SampleNoiseData(llll15, stylingDataCastShadows, stylingRandomDataCastShadows, requiredNoiseDataCastShadows, lllllllll5, llllllllll5);
                    float llllllllllllllllllllllllllll16 = Hatching(1 - llllllllllllllll10, llll15, stylingDataCastShadows, stylingRandomDataCastShadows, noiseSampleData, llllllllllllllllllllll5);
                    llllllllllllllllllllllllllll16 = 1 - llllllllllllllllllllllllllll16;
                    {
                        llllllllllllllllll16 = min(llllllllllllllllllllllllllll16, llllllllllllllllll16);
                    }
                }
                lllllllllllllllllllllllll14 = llllllllllllllllll16;
            }
            else if (stylingDataCastShadows.style == 1) 
            {                        
                float2 lllllllllllllllllllllllllllllll4 = RotateUV(llllllllll16, stylingDataCastShadows.rotation);
                NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllllllllllllllllll4, stylingDataCastShadows, stylingRandomDataCastShadows, requiredNoiseDataCastShadows, lllllllll5, llllllllll5);
                float llllllllllllllllllllllllll6 = Halftones(1 - llllllllllllllll10, lllllllllllllllllllllllllllllll4, stylingDataCastShadows, stylingRandomDataCastShadows, noiseSampleData);
                lllllllllllllllllllllllll14 = llllllllllllllllllllllllll6;            
            }
            DoBlending(lllllllllllllllllllllllllllll6, 1 - lllllllllllllllllllllllll14, positionAndBlendingDataCastShadows.blending, stylingDataCastShadows.color);                    
        }
#endif        
#if _ENABLE_SPECULAR_STYLING || !_USE_OPTIMIZATION_DEFINES   
    #if !_USE_OPTIMIZATION_DEFINES
        if (llllllllll9)   
    #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _SPECULAR_STYLING_BLENDING
                positionAndBlendingDataSpecular.blending = _SPECULAR_STYLING_BLENDING;
            #endif
            #ifdef _SPECULAR_STYLING_DRAWSPACE
                uvSpaceDataSpecular.drawSpace = _SPECULAR_STYLING_DRAWSPACE;
            #endif
            #ifdef _SPECULAR_STYLING_COORDINATESYSTEM
                uvSpaceDataSpecular.coordinateSystem = _SPECULAR_STYLING_COORDINATESYSTEM;
            #endif            
            #ifdef _SPECULAR_STYLE
                stylingDataSpecular.style = _SPECULAR_STYLE;
            #endif
            #if _SPECULAR_STYLING_RANDOMIZER
                stylingRandomDataSpecular.enableRandomizer = 1;
            #else
                stylingRandomDataSpecular.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataSpecular;
#if _USE_OPTIMIZATION_DEFINES            
#ifdef _SPECULAR_STYLING_RANDOMIZER_PERLIN
                    requiredNoiseDataSpecular.perlinNoise = 1;
#else
                    requiredNoiseDataSpecular.perlinNoise = 0;
#endif
#ifdef _SPECULAR_STYLING_RANDOMIZER_PERLIN_FLOORED
                    requiredNoiseDataSpecular.perlinNoiseFloored = 1;
#else
                    requiredNoiseDataSpecular.perlinNoiseFloored = 0;
#endif         
#ifdef _SPECULAR_STYLING_RANDOMIZER_WHITE
                    requiredNoiseDataSpecular.whiteNoise = 1;
#else
                    requiredNoiseDataSpecular.whiteNoise = 0;
#endif
#ifdef _SPECULAR_STYLING_RANDOMIZER_WHITE_FLOORED
                    requiredNoiseDataSpecular.whiteNoiseFloored = 1;
#else
                    requiredNoiseDataSpecular.whiteNoiseFloored = 0;
#endif      
#else            
            requiredNoiseDataSpecular.perlinNoise = 1;
            requiredNoiseDataSpecular.perlinNoiseFloored = 1;
            requiredNoiseDataSpecular.whiteNoise = 1;
            requiredNoiseDataSpecular.whiteNoiseFloored = 1;
#endif
        #if _URP
                float2 lllllllllllllllllllllllllllllll16 = ConvertToDrawSpace(inputData, lllllllll1, uvSpaceDataSpecular, llllllllllllllllllllllllllll0, uvSets);
        #else
            float2 lllllllllllllllllllllllllllllll16 = ConvertToDrawSpace(d.worldSpacePosition, d.worldSpaceNormal, lllllllll1, uvSpaceDataSpecular, llllllllllllllllllllllllllll0, uvSets);
            #endif
                float2 lllllllllllllllllllllllllllllll4 = RotateUV(lllllllllllllllllllllllllllllll16, stylingDataSpecular.rotation);
                lllllllllllllllllllllllllllllll16 = lllllllllllllllllllllllllllllll4;
            NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllllllllllllllllll16, stylingDataSpecular, stylingRandomDataSpecular, requiredNoiseDataSpecular, lllllllll5, llllllllll5);
    #if _USE_OPTIMIZATION_DEFINES 
        #ifdef _SPECULAR_STYLE
            stylingDataSpecular.style = _SPECULAR_STYLE;
        #endif
    #endif
            float lllllllllllllllllllllllll14 = 0;     
            if (stylingDataSpecular.style == 0) 
            {               
                lllllllllllllllllllllllll14 = Hatching(lllllllllllllllllll10, lllllllllllllllllllllllllllllll16, stylingDataSpecular, stylingRandomDataSpecular, noiseSampleData, llllllllllllllllllllll5);
                lllllllllllllllllllllllll14 = 1 - lllllllllllllllllllllllll14;
            }
            else if (stylingDataSpecular.style == 1) 
            {
                float llllllllllllllllllllllllll6 = Halftones(lllllllllllllllllll10, lllllllllllllllllllllllllllllll16, stylingDataSpecular, stylingRandomDataSpecular, noiseSampleData);
                lllllllllllllllllllllllll14 = llllllllllllllllllllllllll6;              
            }
            #if _USE_OPTIMIZATION_DEFINES
                #ifdef _SPECULAR_STYLING_BLENDING
                     positionAndBlendingDataSpecular.blending = _SPECULAR_STYLING_BLENDING;
                #endif
            #endif
            half4 lllllllll14;
            if (lllllllllllllll9 == 1)
            {
                lllllllll14 = half4(llllllllllllllllllll10, 1);
            }
            else
            {
                lllllllll14 = stylingDataSpecular.color;
            }
            DoBlending(lllllllllllllllllllllllllllll6, 1 - lllllllllllllllllllllllll14, positionAndBlendingDataSpecular.blending, lllllllll14);
        }
#endif
#if _ENABLE_RIM_STYLING || !_USE_OPTIMIZATION_DEFINES   
        #if !_USE_OPTIMIZATION_DEFINES
        if (lllllllllllllllll9)
        #endif
        {
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _RIM_STYLING_BLENDING
                    positionAndBlendingDataRim.blending = _RIM_STYLING_BLENDING;
            #endif
            #ifdef _RIM_STYLING_DRAWSPACE
                uvSpaceDataRim.drawSpace = _RIM_STYLING_DRAWSPACE;
            #endif
            #ifdef _RIM_STYLING_COORDINATESYSTEM
                uvSpaceDataRim.coordinateSystem = _RIM_STYLING_COORDINATESYSTEM;
            #endif        
            #ifdef _RIM_STYLE
                stylingDataRim.style = _RIM_STYLE;
            #endif
            #if _RIM_STYLING_RANDOMIZER
                stylingRandomDataRim.enableRandomizer = 1;
            #else
                stylingRandomDataRim.enableRandomizer = 0;
            #endif
        #endif
            RequiredNoiseData requiredNoiseDataRim;
        #if _USE_OPTIMIZATION_DEFINES
            #ifdef _RIM_STYLING_RANDOMIZER_PERLIN
                requiredNoiseDataRim.perlinNoise = 1;
            #else
                requiredNoiseDataRim.perlinNoise = 0;
            #endif
            #ifdef _RIM_STYLING_RANDOMIZER_PERLIN_FLOORED
                requiredNoiseDataRim.perlinNoiseFloored = 1;
            #else
                requiredNoiseDataRim.perlinNoiseFloored = 0;
            #endif         
            #ifdef _RIM_STYLING_RANDOMIZER_WHITE
                requiredNoiseDataRim.whiteNoise = 1;
            #else
                requiredNoiseDataRim.whiteNoise = 0;
            #endif
            #ifdef _RIM_STYLING_RANDOMIZER_WHITE_FLOORED
                requiredNoiseDataRim.whiteNoiseFloored = 1;
            #else
                requiredNoiseDataRim.whiteNoiseFloored = 0;
            #endif      
        #else            
            requiredNoiseDataRim.perlinNoise = 1;
            requiredNoiseDataRim.perlinNoiseFloored = 1;
            requiredNoiseDataRim.whiteNoise = 1;
            requiredNoiseDataRim.whiteNoiseFloored = 1;
        #endif
        #if _URP
            float2 lllllll17 = ConvertToDrawSpace(inputData, lllllllll1, uvSpaceDataRim, llllllllllllllllllllllllllll0, uvSets);
        #else
            float2 lllllll17 = ConvertToDrawSpace(d.worldSpacePosition, d.worldSpaceNormal, lllllllll1, uvSpaceDataRim, llllllllllllllllllllllllllll0, uvSets);
        #endif
            float2 lllllllllllllllllllllllllllllll4 = RotateUV(lllllll17, stylingDataRim.rotation);
            NoiseSampleData noiseSampleData = SampleNoiseData(lllllllllllllllllllllllllllllll4, stylingDataRim, stylingRandomDataRim, requiredNoiseDataRim, lllllllll5, llllllllll5);
            if (llllllllllllllllllll8 == 0 || llllllllllllllllll9 == 0) 
            {
            #if _URP
                Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
                float lllllllllll14 = dot(mainLight.direction, lllllllllllllllllllllllllll3);
                float llllllllllll14 = mainLight.shadowAttenuation;
                lllll4 = CalculateRimMask(lllll10, lllllllllllllllllllllllllll1, lllllllllllllllllll9, llllllllllllllllllll9, lllllllllll14, lllllllllllllllllllll9, llllll8, lllllllllllllllllllllllllllllll7, llllllllllll14);
            #else
                lllll4 = CalculateRimMask(lllll10, lllllllllllllllllllllllllll1, lllllllllllllllllll9, llllllllllllllllllll9, llllllllllllllllllllllllllllll1, lllllllllllllllllllll9, llllll8, lllllllllllllllllllllllllllllll7, llll4);
            #endif
            }
            lllll4 = saturate(lllll4 - lllllllllllllllllllllllllllllll1 * 10);
            float lllllllllllllllllllllllll14 = 0;
            if (stylingDataRim.style == 0) 
            {
                lllllllllllllllllllllllll14 = Hatching(lllll4, lllllllllllllllllllllllllllllll4, stylingDataRim, stylingRandomDataRim, noiseSampleData, llllllllllllllllllllll5);
                lllllllllllllllllllllllll14 = 1 - lllllllllllllllllllllllll14;
            }
            else if (stylingDataRim.style == 1) 
            {
                float llllllllllllllllllllllllll6 = Halftones(lllll4, lllllllllllllllllllllllllllllll4, stylingDataRim, stylingRandomDataRim, noiseSampleData);
                lllllllllllllllllllllllll14 = llllllllllllllllllllllllll6;
            }
            DoBlending(lllllllllllllllllllllllllllll6, 1-lllllllllllllllllllllllll14, positionAndBlendingDataRim.blending, stylingDataRim.color);
        }
    #endif
    }
#endif


}

    
    
    
    
    
    
    
    
    
    
    
    
    
    

        


void AddTheToonShader(inout float4 albedo,

#if _URP
    InputData inputData, 
    SurfaceData surface,
#else
    #if _USESPECULAR || _USESPECULARWORKFLOW || _SPECULARFROMMETALLIC
                 SurfaceOutputStandardSpecular o,
    #elif _BDRFLAMBERT || _BDRF3 || _SIMPLELIT

                 SurfaceOutput o,
    #else
                 SurfaceOutputStandard o,
    #endif

    UnityGI gi,
    #if !_PASSFORWARDADD
    UnityGIInput giInput,
    #endif
#endif

 ShaderData d
#if _URP
    #if UNITY_VERSION >= 202120
, float3 normalTS
    #endif
#endif

)
{
    
    float2 uv = d.texcoord0.xy;
    
    UVSets uvSets;  
    uvSets.uv0 = d.texcoord0.xy;
    uvSets.uv1 = d.texcoord1.xy;
    uvSets.uv2 = d.texcoord2.xy;
    uvSets.uv3 = d.texcoord3.xy;
    
    
    
        
    

    
    float3 pureNormal = d.worldSpaceNormal;

    float4 screenUV = d.extraV2F0;

    

    
    UVSpaceData uvSpaceDataShading;
    uvSpaceDataShading.drawSpace = _DrawSpace;
    uvSpaceDataShading.uvSet = _UVSet;
    uvSpaceDataShading.coordinateSystem = _CoordinateSystem;
    uvSpaceDataShading.polarCenterMode = _PolarCenterMode;
    uvSpaceDataShading.polarCenter = _PolarCenter;
    uvSpaceDataShading.sSCameraDistanceScaled = _SSCameraDistanceScaled;
    uvSpaceDataShading.anchorSSToObjectsOrigin = _AnchorSSToObjectsOrigin;
    
     
    
    UVSpaceData uvSpaceDataCastShadows;
    uvSpaceDataCastShadows.drawSpace = _CastShadowsDrawSpace;
    uvSpaceDataCastShadows.uvSet = _CastShadowsUVSet;
    uvSpaceDataCastShadows.coordinateSystem = _CastShadowsCoordinateSystem;
    uvSpaceDataCastShadows.polarCenterMode = _CastShadowsPolarCenterMode;
    uvSpaceDataCastShadows.polarCenter = _CastShadowsPolarCenter;
    uvSpaceDataCastShadows.sSCameraDistanceScaled = _CastShadowsSSCameraDistanceScaled;
    uvSpaceDataCastShadows.anchorSSToObjectsOrigin = _CastShadowsAnchorSSToObjectsOrigin;
    
    UVSpaceData uvSpaceDataSpecular;
    uvSpaceDataSpecular.drawSpace = _SpecularDrawSpace;
    uvSpaceDataSpecular.uvSet = _SpecularUVSet;
    uvSpaceDataSpecular.coordinateSystem = _SpecularCoordinateSystem;
    uvSpaceDataSpecular.polarCenterMode = _SpecularPolarCenterMode;
    uvSpaceDataSpecular.polarCenter = _SpecularPolarCenter;
    uvSpaceDataSpecular.sSCameraDistanceScaled = _SpecularSSCameraDistanceScaled;
    uvSpaceDataSpecular.anchorSSToObjectsOrigin = _SpecularAnchorSSToObjectsOrigin;
    
    UVSpaceData uvSpaceDataRim;
    uvSpaceDataRim.drawSpace = _RimDrawSpace;
    uvSpaceDataRim.uvSet = _RimUVSet;
    uvSpaceDataRim.coordinateSystem = _RimCoordinateSystem;
    uvSpaceDataRim.polarCenterMode = _RimPolarCenterMode;
    uvSpaceDataRim.polarCenter = _RimPolarCenter;
    uvSpaceDataRim.sSCameraDistanceScaled = _RimSSCameraDistanceScaled;
    uvSpaceDataRim.anchorSSToObjectsOrigin = _RimAnchorSSToObjectsOrigin;

    GeneralStylingData generalStylingData;
    generalStylingData.enableDistanceFade = _EnableStylingDistanceFade;
    generalStylingData.distanceFadeStartDistance = _StylingDFStartingDistance;
    generalStylingData.distanceFadeFalloff = _StylingDFFalloff;
    generalStylingData.adjustDistanceFadeValue = _StylingAdjustDistanceFadeValue;
    generalStylingData.distanceFadeValue = _StylingDistanceFadeValue;
    StylingData stylingDataShading;
    stylingDataShading.style = _ShadingStyle;
    stylingDataShading.type = 0;
    stylingDataShading.color = _StylingColor;
    stylingDataShading.rotation = _StylingShadingInitialDirection;
    stylingDataShading.rotationBetweenCells = _StylingShadingRotationBetweenCells;
    stylingDataShading.density = _StylingShadingDensity;
    stylingDataShading.offset = _StylingShadingHalftonesOffset;
    stylingDataShading.size = _StylingShadingThickness;
    stylingDataShading.sizeControl = _StylingShadingThicknessControl;
    stylingDataShading.sizeFalloff = _StylingShadingThicknessFalloff;
    stylingDataShading.roundness = _StylingShadingHalftonesRoundness;
    stylingDataShading.roundnessFalloff = _StylingShadingHalftonesRoundnessFalloff;
    stylingDataShading.hardness = _StylingShadingHardness;
    stylingDataShading.opacity = _StylingShadingOpacity;
    stylingDataShading.opacityFalloff = _StylingShadingOpacityFalloff;

    StylingData stylingDataSpecular;
    stylingDataSpecular.style = _SpecularStyle;
    stylingDataSpecular.type = 1;
    stylingDataSpecular.color = _StylingSpecularColor;
    stylingDataSpecular.rotation = _StylingSpecularRotation;
    stylingDataSpecular.density = _StylingSpecularDensity;
    stylingDataSpecular.offset = _StylingSpecularHalftonesOffset;
    stylingDataSpecular.size = _StylingSpecularThickness;
    stylingDataSpecular.sizeControl = _StylingSpecularThicknessControl;
    stylingDataSpecular.sizeFalloff = _StylingSpecularThicknessFalloff;
    stylingDataSpecular.roundness = _StylingSpecularHalftonesRoundness;
    stylingDataSpecular.roundnessFalloff = _StylingSpecularHalftonesRoundnessFalloff;
    stylingDataSpecular.hardness = _StylingSpecularHardness;
    stylingDataSpecular.opacity = _StylingSpecularOpacity;
    stylingDataSpecular.opacityFalloff = _StylingSpecularOpacityFalloff;

    
    StylingData stylingDataCastShadows;    
    
    stylingDataCastShadows.style = _CastShadowsStyle;
    stylingDataCastShadows.type = 1;
    stylingDataCastShadows.color = _StylingCastShadowsColor;
    stylingDataCastShadows.rotation = _StylingCastShadowsInitialDirection;
    stylingDataCastShadows.rotationBetweenCells = _StylingCastShadowsRotationBetweenCells;
    stylingDataCastShadows.density = _StylingCastShadowsDensity;
    stylingDataCastShadows.offset = _StylingCastShadowsHalftonesOffset;
    stylingDataCastShadows.size = _StylingCastShadowsThickness;
    stylingDataCastShadows.sizeControl = _StylingCastShadowsThicknessControl;
    stylingDataCastShadows.sizeFalloff = _StylingCastShadowsThicknessFalloff;
    stylingDataCastShadows.roundness = _StylingCastShadowsHalftonesRoundness;
    stylingDataCastShadows.roundnessFalloff = _StylingCastShadowsHalftonesRoundnessFalloff;
    stylingDataCastShadows.hardness = _StylingCastShadowsHardness;
    stylingDataCastShadows.opacity = _StylingCastShadowsOpacity;
    stylingDataCastShadows.opacityFalloff = _StylingCastShadowsOpacityFalloff;

    StylingData stylingDataRim;
    stylingDataRim.style = _RimStyle;
    stylingDataRim.type = 1;
    stylingDataRim.color = _StylingRimColor;
    stylingDataRim.rotation = _StylingRimRotation;
    stylingDataRim.density = _StylingRimDensity;
    stylingDataRim.offset = _StylingRimHalftonesOffset;
    stylingDataRim.size = _StylingRimThickness;
    stylingDataRim.sizeControl = _StylingRimThicknessControl;
    stylingDataRim.sizeFalloff = _StylingRimThicknessFalloff;
    stylingDataRim.roundness = _StylingRimHalftonesRoundness;
    stylingDataRim.roundnessFalloff = _StylingRimHalftonesRoundnessFalloff;
    stylingDataRim.hardness = _StylingRimHardness;
    stylingDataRim.opacity = _StylingRimOpacity;
    stylingDataRim.opacityFalloff = _StylingRimOpacityFalloff;

    
 
    
    PositionAndBlendingData positionAndBlendingDataShading;
            
    positionAndBlendingDataShading.blending = _StylingShadingBlending;
    positionAndBlendingDataShading.isInverted = _StylingShadingIsInverted;

    PositionAndBlendingData positionAndBlendingDataSpecular;
            
    positionAndBlendingDataSpecular.blending = _StylingSpecularBlending;
    positionAndBlendingDataSpecular.isInverted = _StylingSpecularIsInverted;
    
    PositionAndBlendingData positionAndBlendingDataCastShadows;
    positionAndBlendingDataCastShadows.blending = _StylingCastShadowsBlending;
    positionAndBlendingDataCastShadows.isInverted = _StylingCastShadowsIsInverted;   
    
    PositionAndBlendingData positionAndBlendingDataRim;
            
    positionAndBlendingDataRim.blending = _StylingRimBlending;
    positionAndBlendingDataRim.isInverted = _StylingRimIsInverted;



    StylingRandomData stylingRandomDataShading;
    stylingRandomDataShading.enableRandomizer = _EnableShadingRandomizer;
    stylingRandomDataShading.perlinNoiseSize = _ShadingNoise1Size;
    stylingRandomDataShading.perlinNoiseSeed = _ShadingNoise1Seed;
    stylingRandomDataShading.whiteNoiseSeed = _ShadingNoise2Seed;
    stylingRandomDataShading.noiseIntensity = _NoiseIntensity;
    stylingRandomDataShading.spacingRandomMode = _SpacingRandomMode;
    stylingRandomDataShading.spacingRandomIntensity = _SpacingRandomIntensity;
    stylingRandomDataShading.opacityRandomMode = _OpacityRandomMode;
    stylingRandomDataShading.opacityRandomIntensity = _OpacityRandomIntensity;
    stylingRandomDataShading.lengthRandomMode = _LengthRandomMode;
    stylingRandomDataShading.lengthRandomIntensity = _LengthRandomIntensity;
    stylingRandomDataShading.hardnessRandomMode = _HardnessRandomMode;
    stylingRandomDataShading.hardnessRandomIntensity = _HardnessRandomIntensity;
    stylingRandomDataShading.thicknessRandomMode = _ThicknessRandomMode;
    stylingRandomDataShading.thicknesshRandomIntensity = _ThicknesshRandomIntensity;
    
    
    
    StylingRandomData stylingRandomDataSpecular;
    stylingRandomDataSpecular.enableRandomizer = _EnableSpecularRandomizer;
    stylingRandomDataSpecular.perlinNoiseSize = _SpecularNoise1Size;
    stylingRandomDataSpecular.perlinNoiseSeed = _SpecularNoise1Seed;
    stylingRandomDataSpecular.whiteNoiseSeed = _SpecularNoise2Seed;
    stylingRandomDataSpecular.noiseIntensity = _SpecularNoiseIntensity;
    stylingRandomDataSpecular.spacingRandomMode = _SpecularSpacingRandomMode;
    stylingRandomDataSpecular.spacingRandomIntensity = _SpecularSpacingRandomIntensity;
    stylingRandomDataSpecular.opacityRandomMode = _SpecularOpacityRandomMode;
    stylingRandomDataSpecular.opacityRandomIntensity = _SpecularOpacityRandomIntensity;
    stylingRandomDataSpecular.lengthRandomMode = _SpecularLengthRandomMode;
    stylingRandomDataSpecular.lengthRandomIntensity = _SpecularLengthRandomIntensity;
    stylingRandomDataSpecular.hardnessRandomMode = _SpecularHardnessRandomMode;
    stylingRandomDataSpecular.hardnessRandomIntensity = _SpecularHardnessRandomIntensity;
    stylingRandomDataSpecular.thicknessRandomMode = _SpecularThicknessRandomMode;
    stylingRandomDataSpecular.thicknesshRandomIntensity = _SpecularThicknesshRandomIntensity;
    
    StylingRandomData stylingRandomDataCastShadows;
    stylingRandomDataCastShadows.enableRandomizer = _EnableCastShadowsRandomizer;
    stylingRandomDataCastShadows.perlinNoiseSize = _CastShadowsNoise1Size;
    stylingRandomDataCastShadows.perlinNoiseSeed = _CastShadowsNoise1Seed;
    stylingRandomDataCastShadows.whiteNoiseSeed = _CastShadowsNoise2Seed;
    stylingRandomDataCastShadows.noiseIntensity = _CastShadowsNoiseIntensity;
    stylingRandomDataCastShadows.spacingRandomMode = _CastShadowsSpacingRandomMode;
    stylingRandomDataCastShadows.spacingRandomIntensity = _CastShadowsSpacingRandomIntensity;
    stylingRandomDataCastShadows.opacityRandomMode = _CastShadowsOpacityRandomMode;
    stylingRandomDataCastShadows.opacityRandomIntensity = _CastShadowsOpacityRandomIntensity;
    stylingRandomDataCastShadows.lengthRandomMode = _CastShadowsLengthRandomMode;
    stylingRandomDataCastShadows.lengthRandomIntensity = _CastShadowsLengthRandomIntensity;
    stylingRandomDataCastShadows.hardnessRandomMode = _CastShadowsHardnessRandomMode;
    stylingRandomDataCastShadows.hardnessRandomIntensity = _CastShadowsHardnessRandomIntensity;
    stylingRandomDataCastShadows.thicknessRandomMode = _CastShadowsThicknessRandomMode;
    stylingRandomDataCastShadows.thicknesshRandomIntensity = _CastShadowsThicknesshRandomIntensity;

    StylingRandomData stylingRandomDataRim;
    stylingRandomDataRim.enableRandomizer = _EnableRimRandomizer;
    stylingRandomDataRim.perlinNoiseSize = _RimNoise1Size;
    stylingRandomDataRim.perlinNoiseSeed = _RimNoise1Seed;
    stylingRandomDataRim.whiteNoiseSeed = _RimNoise2Seed;
    stylingRandomDataRim.noiseIntensity = _RimNoiseIntensity;
    stylingRandomDataRim.spacingRandomMode = _RimSpacingRandomMode;
    stylingRandomDataRim.spacingRandomIntensity = _RimSpacingRandomIntensity;
    stylingRandomDataRim.opacityRandomMode = _RimOpacityRandomMode;
    stylingRandomDataRim.opacityRandomIntensity = _RimOpacityRandomIntensity;
    stylingRandomDataRim.lengthRandomMode = _RimLengthRandomMode;
    stylingRandomDataRim.lengthRandomIntensity = _RimLengthRandomIntensity;
    stylingRandomDataRim.hardnessRandomMode = _RimHardnessRandomMode;
    stylingRandomDataRim.hardnessRandomIntensity = _RimHardnessRandomIntensity;
    stylingRandomDataRim.thicknessRandomMode = _RimThicknessRandomMode;
    stylingRandomDataRim.thicknesshRandomIntensity = _RimThicknesshRandomIntensity;


    DoToonShading(
        #if _URP
            inputData,
            surface,
        #else
            o,
            gi,
            #if !_PASSFORWARDADD
            giInput,
            #endif
        #endif
            d,
        #if _URP
            #if UNITY_VERSION >= 202120
            normalTS,
            #endif
        #endif    
            albedo, _NumberOfCells, _CellTransitionSmoothness, _SumLightsBeforePosterization, _ShadingUseLightColors,
    
            uv, screenUV, _HatchingMap,
            
            _ShadingMode, _LightFunction,

            _EnableToonShading, _ShadingFunction,

            _GradientTex, _GradientTex_TexelSize, _GradientMode, _GradientBlending, _GradientBlendFactor,

            _EnableShadows, _CoreShadowColor, 
    
            _TerminatorPosition,
    
            _TerminatorWidth, _TerminatorSmoothness, _FormShadowColor,
            _EnableCastShadows, _CastShadowsStrength, _CastShadowsSmoothness, _CastShadowColorMode, _CastShadowColor,
            _ShadingAffectedByNormalMap,
    
            _EnableSpecular, _SpecularBlending, _SpecularColor, _SpecularSize, _SpecularSmoothness, _SpecularOpacity, _SpecularAffectedByNormalMap, _SpecularUseLightColors,
            
            _EnableRim, _RimBlending, _RimColor, _RimSize, _RimSmoothness, _RimOpacity, _RimAffectedArea, _RimAffectedByNormalMap,
            
    
            _EnableStyling, 
    
            uvSets,
    
            generalStylingData, _HatchingAffectedByNormalMap, _EnableAntiAliasing,
    
            _EnableShadingStyling, 
            _StylingShadingSyncWithOtherStyling,
            _SyncWithLightPartitioning, _NumberOfCellsHatching, 
            _StylingTerminatorPosition,
            _StylingOvermodelingFactor,
            positionAndBlendingDataShading, uvSpaceDataShading, stylingDataShading, stylingRandomDataShading,
    
            _EnableCastShadowsStyling,
            _StylingCastShadowsSyncWithOtherStyling,
            _CastShadowsNumberOfCellsHatching, _StylingCastShadowsSmoothness, 
            positionAndBlendingDataCastShadows, uvSpaceDataCastShadows, stylingDataCastShadows, stylingRandomDataCastShadows,
    
            _EnableSpecularStyling,
            _SyncWithSpecular, _StylingSpecularSize, _StylingSpecularSmoothness, _StylingSpecularCutOutShading, _StylingSpecularUseLightColors,
            _StylingSpecularSyncWithOtherStyling,
            positionAndBlendingDataSpecular, uvSpaceDataSpecular, stylingDataSpecular, stylingRandomDataSpecular,
    
            _EnableRimStyling,
            _SyncWithRim, _StylingRimSize, _StylingRimSmoothness, _StylingRimAffectedArea, 
            _StylingRimSyncWithOtherStyling,
            positionAndBlendingDataRim, uvSpaceDataRim, stylingDataRim, stylingRandomDataRim,


            _NoiseMap1, _NoiseMap2, _NoiseTex2_TexelSize,   
            
            pureNormal);
    
}










#endif

