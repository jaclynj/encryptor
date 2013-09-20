class Encryptor
  def supported_characters
    (' '..'z').to_a
  end

  def cipher(rotation)
    characters = (' '..'z').to_a
	rotated_characters = characters.rotate(rotation)
	Hash[characters.zip(rotated_characters)]
	end
	
  def encrypt_letter(letter, rotation) 
	cipher_for_rotation = cipher(rotation)
	cipher_for_rotation[letter]
  end
	
  def encrypt(string,rotation)
    letters = string.split("")
	results = letters.collect do |letter|
	encrypt_letter(letter, rotation)
	end
	results.join
  end
	
  def decrypt(string, rotation)
	neg_rotation = rotation*-1
	encrypt(string, neg_rotation)
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
    decrypt(message, attempt)
    end
  end
	
  def encrypt_file(filename, rotation)
	input = File.open(filename, "r")
	text = input.read
	secret_message = encrypt(text, rotation)
	output = File.open("SecretMessage.txt", "w")
	output.write(secret_message)
	input.close
	output.close
  end
	
  def decrypt_file(filename, rotation)
	secret = File.open(filename, "r")
	secret_text = secret.read
	decrypted_message = decrypt(secret_text, rotation)
	output = File.open("AllYourSecrets.txt", "w")
	output.write(decrypted_message)
	secret.close
	output.close
  end

  def realtime_encrypt
	puts "Secret Message?"
	string = gets.chomp
	puts "Rotation?"
	rotation = gets.chomp
	secret_message = encrypt(string, rotation.to_i)
	puts secret_message
  end

  def realtime_decrypt
	puts "Secret Message?"
	string = gets.chomp
	puts "Rotation? Say 'no' if not sure"
	rotation = gets.chomp
	  if rotation.downcase == "no"
	    crack(string)
	  else
	secret_message = decrypt(string, rotation.to_i)
	puts secret_message
	  end
	end
  end
