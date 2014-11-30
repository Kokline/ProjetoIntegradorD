// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:3,uamb:True,mssp:True,lmpd:False,lprd:False,enco:True,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32498,y:32640|diff-2-RGB,diffpow-289-RGB,spec-7-OUT,gloss-6-OUT,normal-3-RGB,amdfl-209-OUT,amspl-4-RGB;n:type:ShaderForge.SFN_Tex2d,id:2,x:33043,y:32508,ptlb:DIFFUSE,ptin:_DIFFUSE,tex:22894b0a9357e424cb878c8b81837c13,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:3,x:33009,y:32703,ptlb:NORMAL,ptin:_NORMAL,tex:9852022e73027fd47ab48431cd1ee520,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:4,x:32861,y:32870,ptlb:S_AL,ptin:_S_AL,tex:96898bf7c4ed42446b226027bc0a9d25,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Cubemap,id:5,x:33112,y:33034,ptlb:CUBEMAP,ptin:_CUBEMAP,cube:36971abbe66158042bd68246fd994cfb,pvfc:0;n:type:ShaderForge.SFN_Slider,id:6,x:33287,y:32908,ptlb:G_Control,ptin:_G_Control,min:0,cur:0.244258,max:1;n:type:ShaderForge.SFN_Slider,id:7,x:33192,y:32659,ptlb:S_Control,ptin:_S_Control,min:0,cur:0.2393162,max:1;n:type:ShaderForge.SFN_Slider,id:8,x:33338,y:33124,ptlb:Env_Control,ptin:_Env_Control,min:0,cur:1.909435,max:5;n:type:ShaderForge.SFN_Tex2d,id:192,x:33112,y:33223,ptlb:Color_TO_BLen,ptin:_Color_TO_BLen,tex:22894b0a9357e424cb878c8b81837c13,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Blend,id:193,x:32916,y:33071,blmd:6,clmp:True|SRC-5-RGB,DST-192-RGB;n:type:ShaderForge.SFN_Multiply,id:209,x:32731,y:33088|A-193-OUT,B-231-RGB,C-8-OUT;n:type:ShaderForge.SFN_Tex2d,id:231,x:32888,y:33270,ptlb:S_G_Channel,ptin:_S_G_Channel,tex:d7dd296d48e224e41ace628efa7d1c4c,ntxv:0,isnm:False;n:type:ShaderForge.SFN_LightColor,id:289,x:32890,y:32613;proporder:2-3-7-5-8-6-4-192-231;pass:END;sub:END;*/

Shader "Shader Forge/Env_shader" {
    Properties {
        _DIFFUSE ("DIFFUSE", 2D) = "white" {}
        _NORMAL ("NORMAL", 2D) = "white" {}
        _S_Control ("S_Control", Range(0, 1)) = 0.2393162
        _CUBEMAP ("CUBEMAP", Cube) = "_Skybox" {}
        _Env_Control ("Env_Control", Range(0, 5)) = 1.909435
        _G_Control ("G_Control", Range(0, 1)) = 0.244258
        _S_AL ("S_AL", 2D) = "white" {}
        _Color_TO_BLen ("Color_TO_BLen", 2D) = "white" {}
        _S_G_Channel ("S_G_Channel", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _DIFFUSE; uniform float4 _DIFFUSE_ST;
            uniform sampler2D _NORMAL; uniform float4 _NORMAL_ST;
            uniform sampler2D _S_AL; uniform float4 _S_AL_ST;
            uniform samplerCUBE _CUBEMAP;
            uniform float _G_Control;
            uniform float _S_Control;
            uniform float _Env_Control;
            uniform sampler2D _Color_TO_BLen; uniform float4 _Color_TO_BLen_ST;
            uniform sampler2D _S_G_Channel; uniform float4 _S_G_Channel_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_303 = i.uv0;
                float3 normalLocal = tex2D(_NORMAL,TRANSFORM_TEX(node_303.rg, _NORMAL)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), _LightColor0.rgb)*InvPi * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
///////// Gloss:
                float gloss = _G_Control;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_S_Control,_S_Control,_S_Control);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float HdotL = max(0.0,dot(halfDirection,lightDirection));
                float3 fresnelTerm = specularColor + ( 1.0 - specularColor ) * pow((1.0 - HdotL),5);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float3 fresnelTermAmb = specularColor + ( 1.0 - specularColor ) * ( pow((1.0 - NdotV),5) / (4-3*gloss) );
                float alpha = 1.0 / ( sqrt( (Pi/4.0) * specPow + Pi/2.0 ) );
                float visTerm = ( NdotL * ( 1.0 - alpha ) + alpha ) * ( NdotV * ( 1.0 - alpha ) + alpha );
                visTerm = 1.0 / visTerm;
                float normTerm = (specPow + 8.0 ) / (8.0 * Pi);
                float3 specularAmb = tex2D(_S_AL,TRANSFORM_TEX(node_303.rg, _S_AL)).rgb * fresnelTermAmb;
                float3 specular = (floor(attenuation) * _LightColor0.xyz)*NdotL * pow(max(0,dot(halfDirection,normalDirection)),specPow)*fresnelTerm*visTerm*normTerm + specularAmb;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight += (saturate((1.0-(1.0-texCUBE(_CUBEMAP,viewReflectDirection).rgb)*(1.0-tex2D(_Color_TO_BLen,TRANSFORM_TEX(node_303.rg, _Color_TO_BLen)).rgb)))*tex2D(_S_G_Channel,TRANSFORM_TEX(node_303.rg, _S_G_Channel)).rgb*_Env_Control); // Diffuse Ambient Light
                diffuseLight *= 1-specularMonochrome;
                finalColor += diffuseLight * tex2D(_DIFFUSE,TRANSFORM_TEX(node_303.rg, _DIFFUSE)).rgb;
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _DIFFUSE; uniform float4 _DIFFUSE_ST;
            uniform sampler2D _NORMAL; uniform float4 _NORMAL_ST;
            uniform float _G_Control;
            uniform float _S_Control;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_304 = i.uv0;
                float3 normalLocal = tex2D(_NORMAL,TRANSFORM_TEX(node_304.rg, _NORMAL)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), _LightColor0.rgb)*InvPi * attenColor;
///////// Gloss:
                float gloss = _G_Control;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_S_Control,_S_Control,_S_Control);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float HdotL = max(0.0,dot(halfDirection,lightDirection));
                float3 fresnelTerm = specularColor + ( 1.0 - specularColor ) * pow((1.0 - HdotL),5);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float alpha = 1.0 / ( sqrt( (Pi/4.0) * specPow + Pi/2.0 ) );
                float visTerm = ( NdotL * ( 1.0 - alpha ) + alpha ) * ( NdotV * ( 1.0 - alpha ) + alpha );
                visTerm = 1.0 / visTerm;
                float normTerm = (specPow + 8.0 ) / (8.0 * Pi);
                float3 specular = attenColor*NdotL * pow(max(0,dot(halfDirection,normalDirection)),specPow)*fresnelTerm*visTerm*normTerm;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight *= 1-specularMonochrome;
                finalColor += diffuseLight * tex2D(_DIFFUSE,TRANSFORM_TEX(node_304.rg, _DIFFUSE)).rgb;
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
