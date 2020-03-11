Shader "custom/SDCustomCARN"
{
    Properties
    {
        //NormalMap
        _MainTex2("Main Texture", 2D) = "white" {}
        _NormalTex("Normal Texture", 2D) = "bump" {}
        //NormalStrength
        _Albedo("Albedo Principal", Color) = (1, 1, 1, 1)
        //RimLigth
        [HDR] _RimColor("Rim Color", Color) = (1, 0, 0, 1)
        _RimPower("Rim Power", Range(0.0, 8.0)) = 1.0
        
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }
    
    
    CGPROGRAM
        //NormalMap
        sampler _MainTex2;
        sampler _NormalTex;
    


    
    ENDCG
    }
 }