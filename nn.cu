#include <iostream>
#include <cstdlib>

using namespace std;

int rand();
float RandomNumber(float Min, float Max)
{
    return ((float(rand()) / float(RAND_MAX)) * (Max - Min)) + Min;
}


float sigmoid(float x){
    return 1 / (1 + exp(-x));
}

float sigmoid_der(float x){
    return sigmoid(x) * (1 - sigmoid(x));
}

float * dot_matrix(float m1[3], float m2[3]){
    // dot product code will be here
    // m = matrik indeks 1
    static float C[1];
    
    C[0] = 0;
    for (int j = 0; j < 3; j++){
        C[0] +=  m1[j] * m2[j];
    }
    return C;
}

int main(){

    cout << "Neural Network Start" << endl;

    float feature_set[5][3] = {{0,1,0},{0,0,1},{1,0,0},{1,1,0},{1,1,1}};
    float label[5][1] = {{1},{0},{0},{1},{1}};

    float *inputs;
    float suminput;
    float activation1;
    int ri;
    float error, dcost_dpred, dpred_dz, z_delta;

    float weight[3];
    float bias[1][1];
    float learning_rate = 0.005;

    // filling weight with random number
    for(int i = 0; i < 3; i++){
        weight[i] = RandomNumber(-1, 1);
    }
    // Training Phase
    int epoch = 1000;
    for(int i = 0; i < epoch; i++){
        ri = rand() % 5;

        inputs = dot_matrix(feature_set[ri], weight);
        for(int j = 0; j < 5; j++)
            suminput += inputs[j];
        // suminput += bias[0][0];

        activation1 = sigmoid(suminput);
        error = activation1 - label[ri][0];

        dcost_dpred = error;
        dpred_dz = sigmoid_der(activation1);
        z_delta = dcost_dpred * dpred_dz;

        for(int j = 0; j < 3; j++){
            weight[j] -= (learning_rate * inputs[j] * z_delta);
        }
        // bias -= learning_rate * z_delta;

        cout << i <<" activation : " << activation1 << " Data Ke : " << ri << " error : " << error << endl;
    }
    
    return 0; 
}