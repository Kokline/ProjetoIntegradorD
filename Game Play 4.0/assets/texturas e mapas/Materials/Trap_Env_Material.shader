// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:True,lprd:False,enco:True,frtr:True,vitr:True,dbil:True,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32648,y:32659|diff-2-RGB,spec-44-OUT,gloss-99-OUT,normal-3-RGB,lwrap-183-RGB,amdfl-4-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33027,y:32474,ptlb:DIFF,ptin:_DIFF,tex:808792976a2a25b43a4519ef9832b7e2,ntxv:0,isnm:False|UVIN-189-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:3,x:32944,y:32964,ptlb:Nnormal_map,ptin:_Nnormal_map,tex:3bfb71e628dd7674e9c062f223c1f484,ntxv:0,isnm:False|UVIN-210-UVOUT,MIP-106-OUT;n:type:ShaderForge.SFN_Multiply,id:4,x:33158,y:32930|A-38-RGB,B-38-RGB,C-60-OUT;n:type:ShaderForge.SFN_Tex2d,id:32,x:33368,y:32613,ptlb:G_Map,ptin:_G_Map,tex:4e1db643811f49742a95c4cefd343002,ntxv:0,isnm:False|UVIN-189-UVOUT,MIP-99-OUT;n:type:ShaderForge.SFN_Tex2d,id:38,x:33428,y:32942,ptlb:node_38,ptin:_node_38,tex:6bee1718be157b34bac8702be3a079c8,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:44,x:33010,y:32683,ptlb:SPECULAR_CTRL,ptin:_SPECULAR_CTRL,min:0,cur:0.1282051,max:1;n:type:ShaderForge.SFN_Slider,id:60,x:33350,y:33155,ptlb:PBL,ptin:_PBL,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:99,x:33543,y:32812,ptlb:GLOSSINESS,ptin:_GLOSSINESS,min:0,cur:0.2649573,max:1;n:type:ShaderForge.SFN_Slider,id:106,x:33029,y:33229,ptlb:Normal_Map,ptin:_Normal_Map,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:183,x:33027,y:32803,ptlb:Light_Wrapping,ptin:_Light_Wrapping,tex:6bee1718be157b34bac8702be3a079c8,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:189,x:33591,y:32450,uv:0;n:type:ShaderForge.SFN_TexCoord,id:210,x:33227,y:33070,uv:0;proporder:2-38-44-3-60-32-99-106-183;pass:END;sub:END;*/

Shader "Shader Forge/Trap_Env_Material" {
    Properties {
        _DIFF ("DIFF", 2D) = "white" {}
        _node_38 ("node_38", 2D) = "white" {}
        _SPECULAR_CTRL ("SPECULAR_CTRL", Range(0, 1)) = 0.1282051
        _Nnormal_map ("Nnormal_map", 2D) = "white" {}
        _PBL ("PBL", Range(0, 1)) = 1
        _G_Map ("G_Map", 2D) = "white" {}
        _GLOSSINESS ("GLOSSINESS", Range(0, 1)) = 0.2649573
        _Normal_Map ("Normal_Map", Range(0, 1)) = 1
        _Light_Wrapping ("Light_Wrapping", 2D) = "white" {}
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            #pragma glsl
            #ifndef LIGHTMAP_OFF
                float4 unity_LightmapST;
                sampler2D unity_Lightmap;
                #ifndef DIRLIGHTMAP_OFF
                    sampler2D unity_LightmapInd;
                #endif
            #endif
            uniform sampler2D _DIFF; uniform float4 _DIFF_ST;
            uniform sampler2D _Nnormal_map; uniform float4 _Nnormal_map_ST;
            uniform sampler2D _node_38; uniform float4 _node_38_ST;
            uniform float _SPECULAR_CTRL;
            uniform float _PBL;
            uniform float _GLOSSINESS;
            uniform float _Normal_Map;
            uniform sampler2D _Light_Wrapping; uniform float4 _Light_Wrapping_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 binormalDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                #ifndef LIGHTMAP_OFF
                    float2 uvLM : TEXCOORD7;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.tangentDir = normalize( mul( _Object2World, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.binormalDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                #ifndef LIGHTMAP_OFF
                    o.uvLM = v.texcoord1 * unity_LightmapST.xy + unity_LightmapST.zw;
                #endif
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.binormalDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float2 node_210 = i.uv0;
                float3 normalLocal = tex2Dlod(_Nnormal_map,float4(TRANSFORM_TEX(node_210.rg, _Nnormal_map),0.0,_Normal_Map)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                #ifndef LIGHTMAP_OFF
                    float4 lmtex = tex2D(unity_Lightmap,i.uvLM);
                    #ifndef DIRLIGHTMAP_OFF
                        float3 lightmap = DecodeLightmap(lmtex);
                        float3 scalePerBasisVector = DecodeLightmap(tex2D(unity_LightmapInd,i.uvLM));
                        UNITY_DIRBASIS
                        half3 normalInRnmBasis = saturate (mul (unity_DirBasis, normalLocal));
                        lightmap *= dot (normalInRnmBasis, scalePerBasisVector);
                    #else
                        float3 lightmap = DecodeLightmap(lmtex);
                    #endif
                #endif
                #ifndef LIGHTMAP_OFF
                    #ifdef DIRLIGHTMAP_OFF
                        float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                    #else
                        float3 lightDirection = normalize (scalePerBasisVector.x * unity_DirBasis[0] + scalePerBasisVector.y * unity_DirBasis[1] + scalePerBasisVector.z * unity_DirBasis[2]);
                        lightDirection = mul(lightDirection,tangentTransform); // Tangent to world
                    #endif
                #else
                    float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                #endif
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i)*2;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float2 node_214 = i.uv0;
                float3 w = tex2D(_Light_Wrapping,TRANSFORM_TEX(node_214.rg, _Light_Wrapping)).rgb*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                #ifndef LIGHTMAP_OFF
                    float3 diffuse = lightmap.rgb;
                #else
                    float3 diffuse = forwardLight/(Pi*(dot(w,float3(0.3,0.59,0.11))+1)) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb*2;
                #endif
///////// Gloss:
                float gloss = _GLOSSINESS;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_SPECULAR_CTRL,_SPECULAR_CTRL,_SPECULAR_CTRL);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float normTerm = (specPow + 8.0 ) / (8.0 * Pi);
                float3 specular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor*normTerm;
                #ifndef LIGHTMAP_OFF
                    #ifndef DIRLIGHTMAP_OFF
                        specular *= lightmap;
                    #else
                        specular *= (floor(attenuation) * _LightColor0.xyz);
                    #endif
                #else
                    specular *= (floor(attenuation) * _LightColor0.xyz);
                #endif
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float4 node_38 = tex2D(_node_38,TRANSFORM_TEX(node_214.rg, _node_38));
                diffuseLight += (node_38.rgb*node_38.rgb*_PBL); // Diffuse Ambient Light
                diffuseLight *= 1-specularMonochrome;
                float2 node_189 = i.uv0;
                finalColor += diffuseLight * tex2D(_DIFF,TRANSFORM_TEX(node_189.rg, _DIFF)).rgb;
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash d3d11_9x 
            #pragma target 3.0
            #pragma glsl
            #ifndef LIGHTMAP_OFF
                float4 unity_LightmapST;
                sampler2D unity_Lightmap;
                #ifndef DIRLIGHTMAP_OFF
                    sampler2D unity_LightmapInd;
                #endif
            #endif
            uniform sampler2D _DIFF; uniform float4 _DIFF_ST;
            uniform sampler2D _Nnormal_map; uniform float4 _Nnormal_map_ST;
            uniform float _SPECULAR_CTRL;
            uniform float _GLOSSINESS;
            uniform float _Normal_Map;
            uniform sampler2D _Light_Wrapping; uniform float4 _Light_Wrapping_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
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
                float2 node_210 = i.uv0;
                float3 normalLocal = tex2Dlod(_Nnormal_map,float4(TRANSFORM_TEX(node_210.rg, _Nnormal_map),0.0,_Normal_Map)).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i)*2;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float2 node_215 = i.uv0;
                float3 w = tex2D(_Light_Wrapping,TRANSFORM_TEX(node_215.rg, _Light_Wrapping)).rgb*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 diffuse = forwardLight/(Pi*(dot(w,float3(0.3,0.59,0.11))+1)) * attenColor;
///////// Gloss:
                float gloss = _GLOSSINESS;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_SPECULAR_CTRL,_SPECULAR_CTRL,_SPECULAR_CTRL);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float normTerm = (specPow + 8.0 ) / (8.0 * Pi);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow) * specularColor*normTerm;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight *= 1-specularMonochrome;
                float2 node_189 = i.uv0;
                finalColor += diffuseLight * tex2D(_DIFF,TRANSFORM_TEX(node_189.rg, _DIFF)).rgb;
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
