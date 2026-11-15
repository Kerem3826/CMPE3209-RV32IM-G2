/* Kerem Yılmaz, 5001240012, G2 */
#define N 36
const int SID = 1240012;
const unsigned int R = 101;
const unsigned int B = 0;
const unsigned int P = 50 + (SID%10);


int arr[N];

unsigned int bucket[5];
unsigned int mean;
unsigned int below_count = 0;
unsigned int pass_count = 0;

int passCheck(unsigned int r){
    if(r>=P){
        return 1;
    }   
    else return 0;
}

int main(){

    unsigned int x = SID;
    unsigned int sum = 0;
    unsigned int i;

    for (i = 0; i < N; i++){
        x = 1664525 * x + 1013904223;
        arr[i] = ((x >> 16) % R) + B;

        if(arr[i]<50) bucket[0]++;
        else if(arr[i]<65) bucket[1]++;
        else if(arr[i]<75) bucket[2]++;
        else if(arr[i]<85) bucket[3]++;
        else bucket[4]++;

        sum += arr[i];
    }

    for (i = 0; i < N; i++){
        pass_count += passCheck(arr[i]);
    }

    mean = sum/N;

    for (i = 0; i < N; i++){
        
        if(arr[i] < mean){
            arr[i] = arr[i] | 0x100;
            below_count++;
        }
    }
    
    return 0;
}