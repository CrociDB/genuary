/*
 * Genuary 2024 #3
 *
 * A simple implementation of the effect over a fast moving environment of popcorn shaped objects.
 *
 */

const vec3 colors[4] = vec3[](
    vec3(0.482,0.827,0.917),
    vec3(0.631,0.933,0.741),
    vec3(0.964,0.968,0.768),
    vec3(0.964,0.839,0.839));

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord / iResolution.xy) - .5;

    vec3 col;

    vec2 iuv = uv;

    for (int i=0; i < 24; i++)
    {
        float v = 0.5 / (float(i+1) / 1.0);
        if (abs(uv.x) <= v && abs(uv.y) <= v)
        {
            iuv = uv*float(i+1);
            col = texture(iChannel0, iuv + .5).xyz;
            col *= colors[(i+int(iTime * 1.2))%4];

            float c = pow(1.0 - clamp(0.0, 1.0, (float(i)/24.0)), 5.0);
            col = mix(vec3(0.0, 0.0, 0.0), col, c);
        }
    }

    if (abs(uv.x) <= .003 && abs(uv.y) <= .42)
    {
        col = colors[(int(iTime * 1.2))%4];
    }


    col.xyz = pow(col.xyz, vec3(0.735));

    fragColor = vec4(col, 1.0);
}
