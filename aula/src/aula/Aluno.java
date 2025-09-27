package aula;

public class Aluno extends Pessoa{
	
	public Aluno(String nome, String cpf) {
		super(nome, cpf);// super classe mae ou superior
		System.out.println("Contrutor do aluno");
	}
	public void saudacao() {
		System.out.println(getNome());//o nome nao pode ser pego mas o getNome pode pq ele é publico
		System.out.println(nome);// agora posso pegar pq coloquei o protected ao inves do private na variavel nome 
		}

}