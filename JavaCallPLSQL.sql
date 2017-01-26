--DROP JAVA SOURCE xxmu_hcm_zip;
--SELECT * FROM dba_objects o WHERE o.object_name LIKE 'xxmu_hcm_zip';
CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED XXMU_HCM_ZIP AS
import java.io.*;
import java.util.zip.*;
public class XXMU_HCM_ZIP{

    public static String createZipHCM(String directoryPath){
      try{
        // input file
        FileInputStream in = new FileInputStream(directoryPath+"HCM_test.txt");

        // out put file
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(directoryPath+"tmp.zip"));

        // name the file inside the zip  file
        out.putNextEntry(new ZipEntry("dir1/zippedjava.txt"));

        // buffer size
        byte[] b = new byte[1024];
        int count;

        while ((count = in.read(b)) > 0) {
          System.out.println();
          out.write(b, 0, count);
        }
        out.close();
        in.close();
        return "SUCCESS";
      }catch(Exception exc){
        return exc.getMessage();
      }
   }
}

CREATE OR REPLACE PACKAGE BODY xx_hcm_zip_pkg AS
  FUNCTION f_create_zip(p_directory_path VARCHAR2) RETURN VARCHAR2 AS
    LANGUAGE JAVA NAME 'XXMU_HCM_ZIP.createZipHCM( java.lang.String ) return java.lang.String';
END xx_hcm_zip_pkg;
