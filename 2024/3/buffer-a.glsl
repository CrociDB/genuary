#define MAX_STEPS			200
#define MAX_DIST			20.0
#define SURFACE_DIST		0.001

float sdfSphere(vec3 p, float s){ return length(p)-s; }

vec4 map(vec3 p)
{
    vec3 sp = vec3(0.5,0.5,0.5) + ((texture(iChannel0, round(p.yz * 2.0) * .1)).xyz-.5) * .2;
    float s = sdfSphere(mod(abs(p),vec3(1.0))-sp,0.07);
    s-=+ (texture(iChannel0, (p.xy + iTime * .1) * 0.2).r) * .03;

    return vec4(s, p);
}

vec3 normal(vec3 p)
{
    // inspired by tdhooper and klems - a way to prevent the compiler from inlining map() 4 times
    vec3 n = vec3(0.0);
    for(int i=(min(iFrame,0)); i<4; i++)
    {
        vec3 e = 0.5773*(2.0*vec3((((i+3)>>1)&1),((i>>1)&1),(i&1))-1.0);
        n += e*map(p+0.0001*e).x;
    }
    return normalize(n);
}

vec4 march(vec3 ro, vec3 rd)
{
    float t = 0.0;
    vec3 p;
    vec4 obj;
    for (int i = 0; i < MAX_STEPS; i++)
    {
        p = ro + t * rd;
        obj = map(p);
        if (abs(obj.x) < SURFACE_DIST || abs(t) > MAX_DIST) break;
        t += obj.x;
    }
    obj.x = t;
    return obj;
}

vec3 render(vec4 obj, vec2 uv, vec3 ro, vec3 rd)
{
    vec3 background = vec3(0.4);
    vec3 col = background;

    if (obj.x < MAX_DIST)
    {
        col = vec3(1.0);

        vec3 n = normal(obj.yzw);
        vec3 light_dir = normalize(ro - obj.yzw);
        vec3 refd = reflect(rd, n);
        float diff = max(0.0, dot(light_dir, n));
        col += diff * background;

        col = mix(background, col, pow(1.0-min(length(obj.yzw - ro),MAX_DIST)/MAX_DIST,2.6));
    }

    return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = ((fragCoord - .5 * iResolution.xy) / iResolution.y);

    vec3 col;

    float angularspeed = iTime * 1.5 + sin(iTime * 1.5) * 1.4;
    float cas = cos(angularspeed);
    float sas = sin(angularspeed);
    uv = mat2(vec2(cas, -sas), vec2(sas, cas)) * (uv);

    vec2 uv2 = (fragCoord / iResolution.xy) - .5;
    if (abs(uv2.x) > .25 || abs(uv2.y) > .25)
    {
        vec3 ro = vec3(0.0,cos(iTime*10.2 + sin(iTime * 6.2) * 0.5)*.3,-sin(iTime*.5) * 8.0);
        vec3 rd = normalize(vec3(uv.x * 1.3, uv.y * 1.3, 1.0));
        vec4 obj = march(ro, rd);
        col = render(obj, uv, ro, rd);
        col *=.2;
        col += texture(iChannel1, (fragCoord / iResolution.xy)).xyz * .8;
    }

    fragColor = vec4(col,1.0);
}
