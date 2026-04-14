#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

int main(){
    char fun[6];
    int a,b;
    void*curr=NULL;
    int (*currfun)(int,int)=NULL;
    char last[6]="";
    while (scanf("%5s%d%d",fun,&a,&b)==3){
        if (strcmp(last,fun)!=0){
            if (curr!=NULL){dlclose(curr);curr=NULL;}
            char name[15];
            strcpy(name,"./lib");
            strcat(name,fun);
            strcat(name,".so");
            curr=dlopen(name,RTLD_LAZY);
currfun=(int(*)(int,int))dlsym(curr,fun);
strcpy(last,fun);
        }
        int ans=currfun(a,b);
        printf("%d\n",ans);
    }
    if (curr!=NULL){dlclose(curr);}
    return 0;
}