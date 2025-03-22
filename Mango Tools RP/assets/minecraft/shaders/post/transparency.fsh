#version 150

uniform sampler2D MainSampler;
uniform sampler2D MainDepthSampler;
uniform sampler2D TranslucentSampler;
uniform sampler2D TranslucentDepthSampler;
uniform sampler2D ItemEntitySampler;
uniform sampler2D ItemEntityDepthSampler;
uniform sampler2D ParticlesSampler;
uniform sampler2D ParticlesDepthSampler;
uniform sampler2D WeatherSampler;
uniform sampler2D WeatherDepthSampler;
uniform sampler2D CloudsSampler;
uniform sampler2D CloudsDepthSampler;

in vec2 texCoord;

#define NUM_LAYERS 6

vec4 color_layers[NUM_LAYERS];
float depth_layers[NUM_LAYERS];
int active_layers = 0;

out vec4 fragColor;

void try_insert( vec4 color, float depth ) {
    if ( color.a == 0.0 ) {
        return;
    }

    color_layers[active_layers] = color;
    depth_layers[active_layers] = depth;

    int jj = active_layers++;
    int ii = jj - 1;
    while ( jj > 0 && depth_layers[jj] > depth_layers[ii] ) {
        float depthTemp = depth_layers[ii];
        depth_layers[ii] = depth_layers[jj];
        depth_layers[jj] = depthTemp;

        vec4 colorTemp = color_layers[ii];
        color_layers[ii] = color_layers[jj];
        color_layers[jj] = colorTemp;

        jj = ii--;
    }
}

vec3 blend( vec3 dst, vec4 src ) {
    return ( dst * ( 1.0 - src.a ) ) + src.rgb;
}

vec4 glitch(sampler2D screen) {
    float intensity = 20.0;
    float rAngle = 0.0;
    float gAngle = 120.0;
    float bAngle = 240.0;
    float rRange = 1.0;
    float gRange = 0.0;
    float bRange = 1.0;
    float distParam = 2.0;

    vec4 col = texture(screen, texCoord);

    // 색수차 효과의 적용 각도 라디안값으로 변환
    float rRadian = radians(rAngle);
    float gRadian = radians(gAngle);
    float bRadian = radians(bAngle);

    // 색수차 효과 벡터의 크기를 조정
    float rMotionValue = rRange * intensity * 0.001;
    float gMotionValue = gRange * intensity * 0.001;
    float bMotionValue = bRange * intensity * 0.001;

    // Distance 함수를 사용해 화면 외곽부로 갈수록 효과 강해지게 하기
    float distanceValue = distance(vec2(0.5, 0.5), texCoord);

    rMotionValue = rMotionValue * (1 - distParam) + (rMotionValue * distanceValue) * distanceValue;
    gMotionValue = gMotionValue * (1 - distParam) + (gMotionValue * distanceValue) * distanceValue;
    bMotionValue = bMotionValue * (1 - distParam) + (bMotionValue * distanceValue) * distanceValue;

    // 각도에 맞게 색수차 효과를 내줄 벡터 회전
    vec2 rMotion = vec2(cos(rRadian), sin(rRadian)) * rMotionValue;
    vec2 gMotion = vec2(cos(gRadian), sin(gRadian)) * gMotionValue;
    vec2 bMotion = vec2(cos(bRadian), sin(bRadian)) * bMotionValue;

    // 채널별 UV에 색수차 효과 벡터를 더해 이미지를 채널별로 움직임
    col.r = texture(screen, texCoord + rMotion).r;
    col.g = texture(screen, texCoord + gMotion).g;
    col.b = texture(screen, texCoord + bMotion).b;

    return col;
}

void main() {
    color_layers[0] = vec4( texture( MainSampler, texCoord ).rgb, 1.0 );
    depth_layers[0] = texture( MainDepthSampler, texCoord ).r;
    active_layers = 1;

    try_insert( texture( TranslucentSampler, texCoord ), texture( TranslucentDepthSampler, texCoord ).r );
    try_insert( texture( ItemEntitySampler, texCoord ), texture( ItemEntityDepthSampler, texCoord ).r );
    try_insert( texture( ParticlesSampler, texCoord ), texture( ParticlesDepthSampler, texCoord ).r );
    try_insert( texture( WeatherSampler, texCoord ), texture( WeatherDepthSampler, texCoord ).r );
    try_insert( texture( CloudsSampler, texCoord ), texture( CloudsDepthSampler, texCoord ).r );

    vec3 texelAccum = color_layers[0].rgb;
    for ( int ii = 1; ii < active_layers; ++ii ) {
        texelAccum = blend( texelAccum, color_layers[ii] );
    }
    
    float marker = texture(ParticlesSampler, vec2(0.0, 0.0)).b * 100;

    // 평상시
    if (abs(marker - 00) < 0.5) {
        fragColor = vec4(texelAccum.rgb, 1.0);
    } else 

    // 색 반전
    if (abs(marker - 01) < 0.5) {
        fragColor = vec4(1 - texelAccum.rgb, 1.0);
    } else 

    // 흑백
    if (abs(marker - 02) < 0.5) {
        float red = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float green = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float blue = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 세피아
    if (abs(marker - 03) < 0.5) {
        float red = texelAccum.r * 0.393 + texelAccum.g * 0.769 + texelAccum.b * 0.189;
        float green = texelAccum.r * 0.349 + texelAccum.g * 0.686 + texelAccum.b * 0.168;
        float blue = texelAccum.r * 0.272 + texelAccum.g * 0.534 + texelAccum.b * 0.131;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 좌우 반전
    if (abs(marker - 04) < 0.5) {
        vec2 flipedCoord = vec2( 1 - texCoord.x , texCoord.y );

        color_layers[0] = vec4( texture( MainSampler, flipedCoord ).rgb, 1.0 );
        depth_layers[0] = texture( MainDepthSampler, flipedCoord ).r;
        active_layers = 1;

        try_insert( texture( TranslucentSampler, flipedCoord ), texture( TranslucentDepthSampler, flipedCoord ).r );
        try_insert( texture( ItemEntitySampler, flipedCoord ), texture( ItemEntityDepthSampler, flipedCoord ).r );
        try_insert( texture( ParticlesSampler, flipedCoord ), texture( ParticlesDepthSampler, flipedCoord ).r );
        try_insert( texture( WeatherSampler, flipedCoord ), texture( WeatherDepthSampler, flipedCoord ).r );
        try_insert( texture( CloudsSampler, flipedCoord ), texture( CloudsDepthSampler, flipedCoord ).r );

        vec3 texelAccum = color_layers[0].rgb;
        for ( int ii = 1; ii < active_layers; ++ii ) {
            texelAccum = blend( texelAccum, color_layers[ii] );
        }
        fragColor = vec4( texelAccum.rgb, 1.0 );
    } else 

    // 상하 반전
    if (abs(marker - 05) < 0.5) {
        vec2 flipedCoord = vec2( texCoord.x , 1 - texCoord.y );

        color_layers[0] = vec4( texture( MainSampler, flipedCoord ).rgb, 1.0 );
        depth_layers[0] = texture( MainDepthSampler, flipedCoord ).r;
        active_layers = 1;

        try_insert( texture( TranslucentSampler, flipedCoord ), texture( TranslucentDepthSampler, flipedCoord ).r );
        try_insert( texture( ItemEntitySampler, flipedCoord ), texture( ItemEntityDepthSampler, flipedCoord ).r );
        try_insert( texture( ParticlesSampler, flipedCoord ), texture( ParticlesDepthSampler, flipedCoord ).r );
        try_insert( texture( WeatherSampler, flipedCoord ), texture( WeatherDepthSampler, flipedCoord ).r );
        try_insert( texture( CloudsSampler, flipedCoord ), texture( CloudsDepthSampler, flipedCoord ).r );

        vec3 texelAccum = color_layers[0].rgb;
        for ( int ii = 1; ii < active_layers; ++ii ) {
            texelAccum = blend( texelAccum, color_layers[ii] );
        }
        fragColor = vec4( texelAccum.rgb, 1.0 );
    } else 

    // 모자이크
    if (abs(marker - 06) < 0.5) {
        float mosaicSize = 100.0;
        vec2 alignedCoord = vec2( round(texCoord.x * mosaicSize) / mosaicSize , round(texCoord.y * mosaicSize) / mosaicSize );

        color_layers[0] = vec4( texture( MainSampler, alignedCoord ).rgb, 1.0 );
        depth_layers[0] = texture( MainDepthSampler, alignedCoord ).r;
        active_layers = 1;

        try_insert( texture( TranslucentSampler, alignedCoord ), texture( TranslucentDepthSampler, alignedCoord ).r );
        try_insert( texture( ItemEntitySampler, alignedCoord ), texture( ItemEntityDepthSampler, alignedCoord ).r );
        try_insert( texture( ParticlesSampler, alignedCoord ), texture( ParticlesDepthSampler, alignedCoord ).r );
        try_insert( texture( WeatherSampler, alignedCoord ), texture( WeatherDepthSampler, alignedCoord ).r );
        try_insert( texture( CloudsSampler, alignedCoord ), texture( CloudsDepthSampler, alignedCoord ).r );

        vec3 texelAccum = color_layers[0].rgb;
        for ( int ii = 1; ii < active_layers; ++ii ) {
            texelAccum = blend( texelAccum, color_layers[ii] );
        }
        fragColor = vec4( texelAccum.rgb, 1.0 );
    } else 

    // 현기증
    if (abs(marker - 07) < 0.5) {
        float actualRadius = 0.5;
        vec4 blurred = vec4(0.0);

        for ( float a = -actualRadius + 0.5; a <= actualRadius; a += 2.0 ) {
            blurred += texture(MainSampler, texCoord + 0.1 * a);
        }
        blurred += texture(MainSampler, texCoord + 0.1 * actualRadius) / 2.0;
        fragColor = blurred / (actualRadius + 0.5);
    } else 

    // 밝게
    if (abs(marker - 8) < 0.5) {
        float light = 3.0;
        fragColor = vec4( vec3( texelAccum.rgb * light ), 1.0 );
    } else 

    // 어둡게
    if (abs(marker - 9) < 0.5) {
        float dark = 3.0;
        fragColor = vec4( vec3( texelAccum.rgb / dark ), 1.0 );
    } else 

    // 비디오 테이프
    if (abs(marker - 10) < 0.5) {
        if ( 0.1 < texCoord.x && texCoord.x < 0.9 ) {
            fragColor = vec4(vec3(texelAccum), 1.0);
            
        } else {
            fragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
        }
    } else 

    // 오류
    if (abs(marker - 11) < 0.5) {
        fragColor = glitch(MainSampler);

        color_layers[0] = vec4( glitch( MainSampler ).rgb, 1.0 );
        depth_layers[0] = glitch( MainDepthSampler ).r;
        active_layers = 1;

        try_insert( glitch( TranslucentSampler ), glitch( TranslucentDepthSampler ).r );
        try_insert( glitch( ItemEntitySampler ), glitch( ItemEntityDepthSampler ).r );
        try_insert( glitch( ParticlesSampler ), glitch( ParticlesDepthSampler ).r );
        try_insert( glitch( WeatherSampler ), glitch( WeatherDepthSampler ).r );
        try_insert( glitch( CloudsSampler ), glitch( CloudsDepthSampler ).r );

        vec3 texelAccum = color_layers[0].rgb;
        for ( int ii = 1; ii < active_layers; ++ii ) {
            texelAccum = blend( texelAccum, color_layers[ii] );
        }
        fragColor = vec4( texelAccum.rgb, 1.0 );
    } else 

    // 비네트
    if (abs(marker - 12) < 0.5) {
        float dist = distance( vec2( 0.5, 0.5 ), texCoord ) * -2 + 1.4;
        fragColor = vec4( vec3( texelAccum.rgb * dist ), 1.0 );
    } else 

    // 오버레이 빨강
    if (abs(marker - 13) < 0.5) {
        float red = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float green = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float blue = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 오버레이 초록
    if (abs(marker - 14) < 0.5) {
        float red = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float green = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float blue = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 오버레이 파랑
    if (abs(marker - 15) < 0.5) {
        float red = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float green = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float blue = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 오버레이 청록
    if (abs(marker - 16) < 0.5) {
        float red = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float green = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float blue = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 오버레이 자홍
    if (abs(marker - 17) < 0.5) {
        float red = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float green = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        float blue = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 오버레이 노랑
    if (abs(marker - 18) < 0.5) {
        float red = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float green = texelAccum.r * 0.3 + texelAccum.g * 0.59 + texelAccum.b * 0.11;
        float blue = texelAccum.r * 0.0 + texelAccum.g * 0.0 + texelAccum.b * 0.0;
        fragColor = vec4(red, green, blue, 1.0);
    } else 

    // 안개 셰이더
    if (abs(marker - 99) < 0.5) {
        float depth = (texture( MainDepthSampler, texCoord ).r - 0.9) * 10;
        fragColor = vec4(depth, depth, depth, 1.0);
    } else 

    if (texCoord.y > 0.98) { if (texCoord.x < marker / 100) { fragColor = vec4(0.0, 0.5, 1.0, 1.0); } else { fragColor = vec4(0.0, 0.0, 0.0, 1.0); } } else { fragColor = vec4(texelAccum.rgb, 1.0); }
}