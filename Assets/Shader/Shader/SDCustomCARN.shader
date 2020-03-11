Shader "custom/SDCustomCARN"
{
    Properties
    {
        //NormalMap
        _MainTex("Main Texture", 2D) = "white" {}
        _NormalTex("Normal Texture", 2D) = "bump" {}
        //NormalStrength
        _Albedo("Albedo Principal", Color) = (1, 1, 1, 1)
        //RimLigth
        [HDR] _RimColor("Rim Color", Color) = (1, 0, 0, 1)
        _RimPower("Rim Power", Range(0.0, 10.0)) = 1.0
        //RampTexture
        _RampTex("Ramp Texture", 2D) = "white" {}
        
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }
    
    
    CGPROGRAM
        #pragma surface surf Ramp

        //NormalMap
        sampler2D _MainTex;
        sampler2D _NormalTex;
        //NormalStrength
        fixed4 _Albedo;
        //RimLight
        half3 _RimColor;
        float _RimPower;
        //RampTexture
        sampler2D _RampTex;

        half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot (s.Normal, lightDir);
            half diff = NdotL * 0.5 + 0.5;
            float2 uv_RampTex = float2(diff,0);
            half3 rampColor = tex2D(_RampTex, uv_RampTex).rgb;
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * atten * rampColor;
            c.a = s.Alpha;
            return c;
        }

           struct Input
        {
            //Ramp
            float a;

            //RimLight
            float3 viewDir;

            //Texture and normal
            float2 uv_MainTex;
            float2 uv_NormalTex;
        };

          void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Albedo.rgb;

            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = texColor.rgb;
            fixed4 normalColor = tex2D(_NormalTex, IN.uv_NormalTex);
            fixed3 normal = UnpackNormal(normalColor);
            o.Normal = normal; 

            float3 nVD = normalize(IN.viewDir);
            float3 NdotV = dot(nVD, o.Normal);
            half rim = 1 - saturate(NdotV);
            o.Emission = _RimColor.rgb * pow(rim, _RimPower);
        }

            
    ENDCG
    }
 }