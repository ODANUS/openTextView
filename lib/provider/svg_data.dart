import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SvgData {
  static SvgPicture dir() {
    return SvgPicture.string(
      """<svg width="16" height="20" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
               <path d="m9.71,0.6l-7.45,0c-1.02,0 -1.86,0.83 -1.86,1.84l0,14.76c0,1.01 0.84,1.84 1.86,1.84l11.18,0c1.02,0 1.86,-0.83 1.86,-1.84l0,-14.76c0,-0.92 -0.93,-1.84 -1.86,-1.84l-3.73,0zl0,0z" id="svg_2" fill="#FFF" fill-opacity="0.6"/>
                <path d="m16.06,8.06l0,-6c0,-1.1 -0.9,-1.99 -2,-1.99l-12,-0.01c-1.1,0 -2,0.9 -2,2l0,16c0,1.1 0.9,2 2,2l10,0c1.1,0 2,-0.9 2,-2l0,-8l2,-2z" id="svg_2" fill="#e2bb70" fill-opacity="0.95"/>
            </svg>""",
      width: 100.w,
      height: 130.h,
    );
  }

  static SvgPicture file(Color c) {
    return SvgPicture.string(
      """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
          <g class="layer">
            <title>Layer 1</title>
             <path d="m11.94,0l-9.55,0c-1.31,0 -2.39,1.07 -2.39,2.39l0,19.1c0,1.31 1.07,2.39 2.39,2.39l14.33,0c1.31,0 2.39,-1.07 2.39,-2.39l0,-14.33l-7.16,-7.16zl0,0z" id="svg_2"/>
          </g>
          </svg>""",
      width: 100.w,
      height: 130.h,
      color: c.withOpacity(0.3),
    );
  }

  static SvgPicture epub() {
    return SvgPicture.string(
      """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
          <g class="layer">
            <title>Layer 1</title>
            <path d="m 16.71 0 l -14.33 0 c -1.31 0 -2.39 1.07 -2.39 2.39 l 0 19.1 c 0 1.31 1.07 2.39 2.39 2.39 l 14.33 0 c 1.31 0 2.39 -1.07 2.39 -2.39 l 0 -19.1 c 0 -1.31 -1.07 -2.39 -2.39 -2.39" id="svg_2"/>
          </g>
          </svg>""",
      width: 100.w,
      height: 130.h,
      color: Color(0xFF81bb0e).withOpacity(0.3),
    );
  }

  static SvgPicture zip() {
    return SvgPicture.string(
      """<svg width="19" height="24" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24">
          <g class="layer">
            <title>Layer 1</title>
            <g id="svg_1">
            <rect fill="none" height="20" id="svg_2" width="16.1" x="-0.1" y="0"/>
            </g>
            <g id="svg_3" transform="rotate(90, 9.56, 11.95)">
            <path d="m19.12,4.78l-9.56,0l-2.39,-2.39l-7.17,0c-1.31,0 -2.38,1.08 -2.38,2.39l-0.01,14.34c0,1.31 1.08,2.39 2.39,2.39l19.12,0c1.31,0 2.39,-1.08 2.39,-2.39l0,-11.95c0,-1.31 -1.08,-2.39 -2.39,-2.39zm-2.39,7.17l-2.39,0l0,2.39l2.39,0l0,2.39l-2.39,0l0,2.39l-2.39,0l0,-2.39l2.39,0l0,-2.39l-2.39,0l0,-2.39l2.39,0l0,-2.39l-2.39,0l0,-2.39l2.39,0l0,2.39l2.39,0l0,2.39z" id="svg_4"/>
            </g>
          </g>
          </svg>""",
      width: 100.w,
      height: 130.h,
      color: Color(0xFF68c99e).withOpacity(0.3),
    );
  }
}
