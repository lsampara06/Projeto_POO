package aula;

public class Pessoa {
	protected String nome;
	protected  String cpf;// hernça= especializacao de uma classe base  
	
	
	public Pessoa(String nome, String cpf) {
		System.out.println("construtor do aluno");
		setNome(nome);
		setCpf(cpf);
	}
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		if(nome.trim().isEmpty()) {
			throw new IllegalArgumentException("nome invalido");
		}
		this.nome = nome ;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

}
