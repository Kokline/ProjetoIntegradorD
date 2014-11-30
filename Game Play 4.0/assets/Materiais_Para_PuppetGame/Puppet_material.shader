// Shader created with Shader Forge Beta 0.36 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.36;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:3,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:1,x:32597,y:32482|diff-10-RGB,spec-869-OUT,gloss-847-OUT,normal-8-RGB,lwrap-845-OUT,amdfl-845-OUT,amspl-845-OUT;n:type:ShaderForge.SFN_Tex2d,id:8,x:33039,y:32632,ptlb:Normal_Map,ptin:_Normal_Map,tex:26e836e9edd20f548b49f415f4861b08,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:10,x:32965,y:32316,ptlb:Color_map,ptin:_Color_map,tex:df8bac8cbb1f1394cbf719216fa18447,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:731,x:33312,y:32902,ptlb:Ambiente_mapa_SPEC,ptin:_Ambiente_mapa_SPEC,tex:77dd3bf4bcf13444597775ddfdbe0cd8,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:789,x:33811,y:32567,ptlb:Skydome,ptin:_Skydome,tex:6bee1718be157b34bac8702be3a079c8,ntxv:0,isnm:True;n:type:ShaderForge.SFN_Multiply,id:845,x:33054,y:32780|A-846-RGB,B-731-A;n:type:ShaderForge.SFN_Cubemap,id:846,x:33572,y:32640,ptlb:CubeMap,ptin:_CubeMap,cube:36971abbe66158042bd68246fd994cfb,pvfc:0|DIR-789-RGB,MIP-878-OUT;n:type:ShaderForge.SFN_Slider,id:847,x:33157,y:32459,ptlb:Gloss_Control,ptin:_Gloss_Control,min:0,cur:0.5641031,max:1;n:type:ShaderForge.SFN_Slider,id:869,x:33279,y:32582,ptlb:Specular_CNTRL,ptin:_Specular_CNTRL,min:0,cur:0.113612,max:1;n:type:ShaderForge.SFN_Slider,id:878,x:33733,y:32820,ptlb:Sky_CONTROL,ptin:_Sky_CONTROL,min:0,cur:0,max:1;proporder:10-8-789-731-846-869-847-878;pass:END;sub:END;*/

Shader "Shader Forge/Puppet_material" {
    Properties {
        _Color_map ("Color_map", 2D) = "white" {}
        _Normal_Map ("Normal_Map", 2D) = "bump" {}
        _Skydome ("Skydome", 2D) = "white" {}
        _Ambiente_mapa_SPEC ("Ambiente_mapa_SPEC", 2D) = "white" {}
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _Specular_CNTRL ("Specular_CNTRL", Range(0, 1)) = 0.113612
        _Gloss_Control ("Gloss_Control", Range(0, 1)) = 0.5641031
        _Sky_CONTROL ("Sky_CONTROL", Range(0, 1)) = 0
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
            #pragma glsl
            uniform float4 _LightColor0;
            uniform sampler2D _Normal_Map; uniform float4 _Normal_Map_ST;
            uniform sampler2D _Color_map; uniform float4 _Color_map_ST;
            uniform sampler2D _Ambiente_mapa_SPEC; uniform float4 _Ambiente_mapa_SPEC_ST;
            uniform sampler2D _Skydome; uniform float4 _Skydome_ST;
            uniform samplerCUBE _CubeMap;
            uniform float _Gloss_Control;
            uniform float _Specular_CNTRL;
            uniform float _Sky_CONTROL;
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
                float2 node_906 = i.uv0;
                float3 normalLocal = UnpackNormal(tex2D(_Normal_Map,TRANSFORM_TEX(node_906.rg, _Normal_Map))).rgb;
                float3 normalDirection =  normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 node_845 = (texCUBElod(_CubeMap,float4(UnpackNormal(tex2D(_Skydome,TRANSFORM_TEX(node_906.rg, _Skydome))).rgb,_Sky_CONTROL)).rgb*tex2D(_Ambiente_mapa_SPEC,TRANSFORM_TEX(node_906.rg, _Ambiente_mapa_SPEC)).a);
                float3 w = node_845*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 diffuse = forwardLight/(Pi*(dot(w,float3(0.3,0.59,0.11))+1)) * attenColor + UNITY_LIGHTMODEL_AMBIENT.rgb;
///////// Gloss:
                float gloss = _Gloss_Control;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_Specular_CNTRL,_Specular_CNTRL,_Specular_CNTRL);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float HdotL = max(0.0,dot(halfDirection,lightDirection));
                float3 fresnelTerm = specularColor + ( 1.0 - specularColor ) * pow((1.0 - HdotL),5);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float3 fresnelTermAmb = specularColor + ( 1.0 - specularColor ) * ( pow((1.0 - NdotV),5) / (4-3*gloss) );
                float alpha = 1.0 / ( sqrt( (Pi/4.0) * specPow + Pi/2.0 ) );
                float visTerm = ( NdotL * ( 1.0 - alpha ) + alpha ) * ( NdotV * ( 1.0 - alpha ) + alpha );
                visTerm = 1.0 / visTerm;
                float normTerm = (specPow + 8.0 ) / (8.0 * Pi);
                float3 specularAmb = node_845 * fresnelTermAmb;
                float3 specular = (floor(attenuation) * _LightColor0.xyz)*NdotL * pow(max(0,dot(halfDirection,normalDirection)),specPow)*fresnelTerm*visTerm*normTerm + specularAmb;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight += node_845; // Diffuse Ambient Light
                diffuseLight *= 1-specularMonochrome;
                finalColor += diffuseLight * tex2D(_Color_map,TRANSFORM_TEX(node_906.rg, _Color_map)).rgb;
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
            #pragma glsl
            uniform float4 _LightColor0;
            uniform sampler2D _Normal_Map; uniform float4 _Normal_Map_ST;
            uniform sampler2D _Color_map; uniform float4 _Color_map_ST;
            uniform sampler2D _Ambiente_mapa_SPEC; uniform float4 _Ambiente_mapa_SPEC_ST;
            uniform sampler2D _Skydome; uniform float4 _Skydome_ST;
            uniform samplerCUBE _CubeMap;
            uniform float _Gloss_Control;
            uniform float _Specular_CNTRL;
            uniform float _Sky_CONTROL;
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
                float2 node_907 = i.uv0;
                float3 normalLocal = UnpackNormal(tex2D(_Normal_Map,TRANSFORM_TEX(node_907.rg, _Normal_Map))).rgb;
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
                float3 node_845 = (texCUBElod(_CubeMap,float4(UnpackNormal(tex2D(_Skydome,TRANSFORM_TEX(node_907.rg, _Skydome))).rgb,_Sky_CONTROL)).rgb*tex2D(_Ambiente_mapa_SPEC,TRANSFORM_TEX(node_907.rg, _Ambiente_mapa_SPEC)).a);
                float3 w = node_845*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = max(float3(0.0,0.0,0.0), NdotLWrap + w );
                float3 diffuse = forwardLight/(Pi*(dot(w,float3(0.3,0.59,0.11))+1)) * attenColor;
///////// Gloss:
                float gloss = _Gloss_Control;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(_Specular_CNTRL,_Specular_CNTRL,_Specular_CNTRL);
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
                finalColor += diffuseLight * tex2D(_Color_map,TRANSFORM_TEX(node_907.rg, _Color_map)).rgb;
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
