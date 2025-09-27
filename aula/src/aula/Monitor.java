package aula;

public class Monitor extends Aluno{
	public Monitor(String nome, String cpf) {
		super(nome,cpf);
		System.out.println("Chamando contrutor do munitor");
	}
	@Override // 
	public void saudacao() {
		
		System.out.println("oi sou monitor");
		super.saudacao(); // o app xchama o m , que chama a saudacao de monitor e o sys e dps pega de aluno 
	}

	@Override
	public String toString(){
		return "Monitor"+nome;
		
	}
}
