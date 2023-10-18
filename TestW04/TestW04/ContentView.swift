import SwiftUI

struct ContentView: View {
    func restart() {
        berapa = 10
        negara = asean
        angkaBenar = 0
        angkaSalah = 0
        random()
    }
    
    func random(){
        if (negara.count < 1){
            angkaRandom = 0
        }
        else{
            angkaRandom = Int.random(in: 0..<negara.count)
        }
    }
    
    func check(angka: Int){
        if (negara[angkaRandom] == asean[angka]){
            angkaBenar += 1
        }
        else{
            angkaSalah += 1
        }
        delete()
        check2()
    }
    
    func check2(){
        if(berapa == 0){
            pesan = "Salah : \(angkaSalah), Benar : \(angkaBenar)"

            if(angkaBenar == 10){
                pesan = "Benar Semua"
            }
            restart()
            showingAlert = true
        }
    }
    func delete(){
        berapa -= 1
        if let index = negara.firstIndex(of: negara[angkaRandom]){
            negara.remove(at: index)
        }
        random()
    }
    
    
    @State private var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State private var negara = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"] // bisa didelete
    @State private var angkaRandom = Int.random(in: 0...9)
    @State private var angkaSalah = 0
    @State private var angkaBenar = 0
    @State private var showingAlert = false
    @State private var berapa = 9
    @State private var pesan = ""
    
    var body: some View {
        ZStack{
            Color.mint
                .ignoresSafeArea()
            
            VStack {
                ZStack{
                    HStack {
                        Spacer().frame(width:50)
                        Button{
                            restart()
                        } label: {
                            Image(systemName: "arrow.clockwise.circle")
                                .imageScale(.large)
                        }
                        Spacer()
                    }
                    ZStack{
                        Capsule()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        Gradient.Stop(color: .red, location: 0.5),
                                        Gradient.Stop(color: .white, location: 0.5)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing))
                            .frame(width: 100, height: 50)
                        HStack{
                            Spacer()
                            Text("\(angkaSalah)").colorInvert()
                            Spacer().frame(width: 40)
                            Text("\(angkaBenar)")
                            Spacer()
                        }
                    }
                    
                }
                Spacer()
                VStack{
                    Text("Pilih Bendera dari Negara : ")
                        .foregroundStyle(.black)
                    Text(negara[angkaRandom])
                        .foregroundStyle(.black)
                }
                Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                HStack{
                    Spacer()
                    VStack{
                        ForEach(0..<5) { number in
                            Button {
                                check(angka: number)
                            } label: {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width:105,height: 65)
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        ForEach(5..<10) { number in
                            Button {
                                check(angka: number)
                            } label: {
                                
                                Image(asean[number])
                                    .resizable()
                                    .frame(width:105,height: 65)
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .alert(pesan, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
