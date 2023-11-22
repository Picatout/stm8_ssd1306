// rotate font 6x8 in font.asm 
// create oled_font.asm


#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

FILE* fi,*fo;


void usage(){
    puts("rotate input-file output-file");
    exit(0);
}

const char dot_byte[]=".byte";

#define LINE_MAX 80 
#define TOK_MAX 32

char iline[LINE_MAX],pline[LINE_MAX],*token;
unsigned int input_hex[8]; // 8 bytes buffer 
unsigned int output_hex[6]; // 6 bytes buffer 


// copy lines to new 
// file to end file 
// or '.byte'
void copy_lines(){
    while (!feof(fi)){
        fgets(iline,LINE_MAX,fi);
        strcpy(pline,iline);
        token=strtok(pline," ,");
        if (!strcmp(dot_byte,token)) break;
        fputs(iline,fo);
    }
}

// convert "0xhh" to integer 
uint8_t tok_to_hex(const char* hex){
    unsigned b,c; 
    for (int i=2;i<4;i++){
        c=hex[i]-'0';
        if (c>9) c-=7;
        b*=16;
        b+=c;
    }
    return b; 
}

// convert 8 bytes to 6 bytes
// rotate pixel 90 degree
// right 
void convert_tok(){
    int i,j;
    unsigned b; 
    for (i=0;i<8;i++){
        input_hex[i]=tok_to_hex(strtok(NULL,", ;"));
    }
    for (i=0;i<6;i++){
        b=0;
        for (j=0;j<8;j++){
            b>>=1;
            if (input_hex[j]&128) b+=128;
            input_hex[j]<<=1;
        }
        output_hex[i]=b;
    }
}

int main(int argc, char** argv){
    if (argc<3) usage();
    fi=fopen(argv[1],"r");
    fo=fopen(argv[2],"w");
    fputs("; rotated 6x8 pixels font to use with ssd1306 oled display\n",fo);
    copy_lines();
    while (!feof(fi) && !strcmp(dot_byte,token)){
        convert_tok();
        fprintf(fo,".byte 0x%02X, 0x%02X, 0x%02X, 0x%02X, 0x%02X, 0x%02X ",output_hex[0],output_hex[1],output_hex[2],output_hex[3],output_hex[4],output_hex[5]);
        token=strchr(iline,';');
        fprintf(fo,"%s",token);
        fgets(iline,LINE_MAX,fi);
        strcpy(pline,iline);
        token=strtok(pline," ,");
    }
    fputs(iline,fo);
    copy_lines();
    fclose(fi);
    fclose(fo);
    return -1;
}


