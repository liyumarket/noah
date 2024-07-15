import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static  TextStyle mediumTitleStyle = GoogleFonts.montserrat(
    color: Color(0xFF363C45),
    fontSize: 18,
  
    fontWeight: FontWeight.w500,
  );

  static  TextStyle mediumSubtitleStyle =GoogleFonts.montserrat(
    color: Color(0xFF363C45),
    fontSize: 14,
    
    fontWeight: FontWeight.w400,
  );
  static  TextStyle cardTitleStyle = GoogleFonts.montserrat(
    fontSize: 14,
    color: Color(0xFF363C45),
    fontWeight: FontWeight.w600,
  );

  static  TextStyle cardsubTitleStyle =  GoogleFonts.montserrat(
     color: Color(0xFFB0B4BE),
    fontSize: 12,

    fontWeight: FontWeight.w400,
  );
  static  TextStyle drawerTextStyle = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 20,
    
    fontWeight: FontWeight.w500,
    letterSpacing: -0.48,
  );
}
