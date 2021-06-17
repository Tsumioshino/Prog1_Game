#$all_p = ((6 * 2) + 1)**2 #169 #!!!!!!!!!!!! 6 !!!!!! dim !!!!!!!!!!! #100% do mapa; #dimensao x 2 + 1 = numero de possibilidades
#$enemy_n = (($all_p - 1) * 0.75 - 1).floor #126 # #Número de inimigos. 75% do mapa 
#$nothing_p = ((($all_p - 1) / 6.25)).floor #26 #Número de nadas. 1% do mapa (se resto não der 0, daria falha) (25.0/4
#$i_p = $all_p - $enemy_n - $nothing_p - 2 #-1#17
$player_hash = {:hero=> {:atk=> ($atk_one = 11)..($atk_two = 18), #Considerar evitar rand, e tentar range (talvez)
                         :hp=> ($hp_one = 14)..($hp_two = 14),
                         :xp=> {:current_xp=>0,
                                :total_xp=>0},
                         :lv=> 1,
                         :spd=> 1,
                         :magic=>{}
                        }
               }
$monsters_hash = {:earth_monsters =>{:slime=> {:atk=>0..0, #(0.2*$enemy_n).floor,
                                               :hp=>12..36,  
                                               :xp=>3,
                                               :quantity=>24},
                                    :goblin=> {:atk=>6..14, #(0.4*$enemy_n).floor
                                               :hp=>14..25,
                                               :xp=>5,
                                               :quantity=>49},
                                    :lizard=> {:atk=>20..28, #(0.2*$enemy_n).floor
                                               :hp=>32..62,
                                               :xp=>30,
                                               :quantity=>24},
                                    :hellhound=> {:atk=>50..72, #(0.19*$enemy_n).floor
                                                  :hp=>38..52,
                                                  :xp=>45,
                                                  :quantity=>23},
                                    :big_demon=> {:atk=>80..140, #(0.01*$enemy_n).floor
                                                  :hp=>100..180,
                                                  :xp=>150,
                                                  :quantity=>1},
                                    :mao=> {:atk=>999..999,
                                            :hp=>999..999,
                                            :xp=>0,
                                            :quantity=>1}
                                     },
                  :underworld_monsters=> {:robot=>{:atk=>30..50,
                                                   :hp=>40..100,
                                                   :xp=>30,
                                                   :quantity=>49,
                                                   :spd=>5},
                                          :ruler_of_the_sky=> {:atk=>70..140,
                                                               :hp=>70..140,
                                                               :xp=>75,
                                                               :quantity=>24,
                                                               :spd=>7},
                                          :ruler_of_the_water=> {:atk=>70..140,
                                                                 :hp=>70..140,
                                                                 :xp=>75,
                                                                 :quantity=>24,
                                                                 :spd=>7},
                                          :ruler_of_the_earth=> {:atk=>70..140,
                                                                 :hp=>70..140,
                                                                 :xp=>75,
                                                                 :quantity=>23,
                                                                 :spd=>7},
                                          :embodiment_of_science=> {:atk=>100..180,
                                                                    :hp=>200..400,
                                                                    :xp=>75,
                                                                    :quantity=>1,
                                                                    :spd=>10},
                                          :the_organization=> {:atk=>50..80, #pode pegar extras turnos
                                                               :hp=>666..999,
                                                               :xp=>0,
                                                               :quantity=>1,
                                                               :spd=>8}
                                          }
                }
$items_hash = {:earth_hash=>{:doc=>8, #5
                            :leather_armor=>1,
                            :iron_armor=>1,
                            :demon_armor=>1,
                            :transcendent_armor=>1,
                            :sacred_armor=>1,
                            :speed_boots=>1,
                            :holy_sword=>1,
                            :demon_sword=>1
                           },
                :underworld_hash=>{:doc=>8,
                                   :fire_gremory=>1,
                                   :water_gremory=>1,
                                   :earth_gremory=>1,
                                   :wind_gremory=>1,
                                   :light_and_dark_gremory=>1,
                                   :phoenix_feather=>2,
                                   :mysterious_book=>1
                                  }
              }
$true_inventory = []
$earth_doc_array = ["Relatório número 000: Você sabia que o comando 'H' lhe mostra a história desse mundo?",
                    "Relatório número 001: slimes se regeneram mesmo que sejam derrotados, o que fazem um inimigo fácil de se utilizar de base para ganho de XP",
                    "Relatório número 004: hellhounds são conhecidos por serem extremamente fortes, mas consideravelmente frágeis.",
                    "Relatório número 007: lizards inflingiam efeitos negativos para capturar suas presas, mas por algum motivo não o inflingem mais...",
                    "Relatório número 013: por algum motivo, os monstros essencialmente se concentram na região sul do mapa; em especial, os goblins.",
                    "Relatório número 015: após lutar com um demônio extremamente forte, cavei minhas botas especiais, com receio de que esse monstro os pegassem caso o pior viesse a acontecer, em algum lugar do mapa, mas não consigo lembrar aonde foi o local exato. Caso alguém leia esse relatório, espero que o encontre.",
                    "Relatório número 028: a Espada Sagrada é uma relíquia de grande poder, mas ninguém consegue-a manejar por requerer um herói... Lendas dizem que ela garante ao herói o poder de derrotar o rei demônio",
                    "Relatório número 030: foi percebido que existem um névoa desconhecida no mapa; geralmente reportada no norte. Ela parece requerer uma pessoa bem-treinada para aguentar a pressão, além de artefatos especiais."
                   ]
$underworld_doc_array = ["Relatório número 038: esse mundo é interessante. Após alguns meses rondando o mesmo, notei que o cenário parece ser de um mundo completamente destruído, mas os seres daqui parecem ser de uma certa forma genuínos, diferentes do outro mundo...",
                         "Relatório número 042: magia exclusiva para esse mundo parece ser estudada por pessoas do alto escalão. Encontrei uma vez um tipo de livro que me permitiu usar algo que talvez poderia ser chamada de 'magia', mas me deu extrema fatiga...",
                         "Relatório número 043: assim como no outro mundo, os monstros se concentram no sul do mapa; em especial, um tipo de metal. Parece que nesse mundo, são chamados de 'Robôs'.",
                         "Relatório número 044: é impossível correr de uma batalha aqui. Os 'robôs' possuem um sistema que lhe rastreia não importa aonde vai, e as bestas, uma vez com olhos na presa, não a deixa escapar de nenhuma forma...",
                         "Relatório número 047: as bestas daqui parecem ser especiais; enquanto tem uma semelhança com animais genuínos, elas possuem magia, algo que supostamente não deveria existir nesse mundo de acordo com minhas pesquisas nesses últimos 8 anos.",
                         "Relatório número 048: após passar cerca de 10 anos aqui, eu descobri que esse mundo era originalmente habitado apenas por humanos e animais normais. Contudo, na tentativa da criação de seres artificiais, parecem ter conseguido implementar ideias e conceitos para a realidade, mas não nesse mundo... Esses seres que vi parecem ter sido experimentos macabros realizado em seres existentes. Tenho medo de que alguém venha me capturar, uma vez que essas informações são de extrema confidencialidade.",
                         "Relatório número 049: hu  a os    t rríve s... Tao f rt q  nt  o rei       ",
                         "Relatório número 050: parece que esse será meu último relatório... O criador do rei demônio e todas essas baboseiras me capturou, e provavelmente vão me utilizar de cobaia para testes macabros. Com o resto da minha magia, vou transportar as chaves para a entrada desse mundo para o outro mundo; não sei quem virá para cá, mas se quiserem de fato terminar esse ciclo, elas serão de suma importância.",
                        ]
class Item
  def initialize(item_value)
    @item_value = item_value
    @modified_atk_one = 0; @modified_atk_two = 0
    @modified_hp_one = 0; @modified_hp_two = 0
    @important_atk_array = []; @important_hp_array = []
  end
  def add_to_inv
    $true_inventory.append(@item_value)
    $true_inventory[$true_inventory.find_index(@item_value)], $true_inventory[-1] = $true_inventory[-1], $true_inventory[$true_inventory.find_index(@item_value)] if @item_value == :holy_sword 
  end
  def earth_items
    case @item_value 
    when :doc then puts ($earth_doc_array.shuffle).pop
    when :leather_armor then @important_hp_array << (@modified_hp_one += (0.1*$hp_one).floor); @important_hp_array << (@modified_hp_two += (0.1*$hp_two).floor)
    when :iron_armor then @important_hp_array << (@modified_hp_one += (0.2*$hp_one).floor); @important_hp_array << (@modified_hp_two += (0.2*$hp_two).floor)
    when :demon_armor then 'Demon... A'
    when :transcendent_armor then @important_hp_array << (@modified_hp_one += ($hp_one).floor); @important_hp_array << (@modified_hp_two = ($hp_two).floor)
    when :sacred_armor then 'Sacred... A' #$mao_hash.each {|mao, mao_att| mao_att.each {|stat, value| $maox_hash[:mao][stat] = $player_hash[:hero][stat]}}
    when :speed_boots then gamble = 1
    when :demon_sword then 'Demon... S'
    when :holy_sword then $monsters_hash[:earth_monsters][:mao].each {|maou, statt| unless (maou == :xp || maou == :quantity) then $monsters_hash[:earth_monsters][:mao][maou] = $player_hash[:hero][maou] end}
    end
  end
  def underworld_items
    case @item_value
    when :doc then puts ($underworld_doc_array.shuffle).pop
    when :fire_gremory then $player_hash[:hero][:magic][@item_value] = 50
    when :water_gremory then $player_hash[:hero][:magic][@item_value] = 50
    when :earth_gremory then $player_hash[:hero][:magic][@item_value] = 50
    when :wind_gremory then $player_hash[:hero][:magic][@item_value] = 50
    when :light_and_dark_gremory then $player_hash[:hero][:magic][@item_value] = 100
    when :mysterious_book then puts 'Você adquiriu um item importante!'
    when :phoenix_feather then puts "Você adquiriu uma pena de fénix!"
    end
  end
  def append_stats
    appended_hp_1 = 0; appended_hp_2 = 0; count = 0
    $true_inventory.each do |item|
      if $items_hash[:earth_hash].include?(item)
        e_element = Item.new(item).earth_items
        if e_element.class == Array
          e_element.each do |element| 
            if (count % 2) == 0
              appended_hp_1 += element 
            elsif (count % 2) == 1
              appended_hp_2 += element
            end
            count += 1
          end
        end
      end
    end
    $player_hash[:hero][:hp] = ($hp_one + appended_hp_1)..($hp_one + appended_hp_2)
  end
  def show_inv
    $true_inventory
  end
  def delete_from_inv
    $true_inventory.delete_at($true_inventory.find_index(@item_value))
  end
  def to_s
    puts "Esse é o inventário: #{$true_inventory}"
  end
end
class Texto
  def tutorial
    puts """Bem vindo, destinado herói. As cordas do destino necessitam de que você encontre o baú que possui a relíquia capaz de salvar o mundo!
  Dessa forma, é necessário que você conheça as regras desse mundo de forma que não sinta dificuldade ao viajar; e, pois, encontrar tal reliquia.
  a) Objetivo:
  Para salvar o mundo, você necessita encontrar a relíquia localizada em algum lugar do mundo. Contudo, o baú está em um local desconhecido, e há 
  diversos inimigos e items espalhados por esse mundo. Por favor, você é a nossa última esperança!    
  b) Mundo:
  Nesse mundo alternativo, você viaja em um mundo 13X13, podendo se movimentar para cima, baixo, esquerda e direita. Além disso, é possível lutar
  contra inimigos para obter XP, de modo que seus status aumentem consideravelmente e possa ficar mais preparado para o futuro. Note que você começa 
  no centro do mapa
  c) Inimigos:
  Slime => Inimigo capaz de se recuperar rapidamente. Mesmo que seja derrotado, ao retornar ao ponto onde ele foi encontrado uma vez, é possível 
  lutar com ele repetidamente;
  Goblin => Inimigo capaz de inflingir dano através de seus golpes rápidos, permitindo críticos acima do comum;
  Lizard => Inimigo capaz de inflngir efeitos negativos consideráveis no herói. Cuidado!
  Hellhound => Inimigo servo dos demônios, são capazes de inflingir grande dano em qualquer ser mais fraco que o mesmo. Cuidado ao enfrentá-lo!
  Demônio General => Inimigo servo do rei demônio, possuem grande poder ofensivo e defensivo, capazes de lhe derrotar rapidamente se você não 
  estiver forte o suficiente. Herói, não lute com ele até que esteja previamente preparado, e corra com todas suas forças caso se encontre com ele!
  Rei Demônio => O mais poderoso inimigo do jogo, que está supervisionando a relíquia de modo com que o herói não seja capaz de salvar o mundo!
  Não tenho informações de como pode ser derrotado, mas assim como o Demônio General, deveria correr caso encontre-o com todas suas forças!
  d) Items: 17 (7, 5)
  Resquísios de Documentos => Provide informações interessantes para o Herói. Quantos resquísios será que existem?;
  Armadura de Couro => Aumenta o HP em 10%;
  Armadura de Ferro => Aumenta o HP em 20%;
  Armadura Demoníaca => Diminui o HP em 50%, e a cada passo movimentado no mapa reduz 1% do HP máximo do usuário;
  Armadura Transcedental => Aumenta o HP em 100%;
  Armadura Sagrada => Não se tem muitas informações sobre, mas dizem que apenas um herói preparado consegue a vestir;
  Botas de Velocidade => Aumentar a probabilidade de fugir de um inimigo para 100%;
  Espada Sagrada => Não se tem muitas informações sobre, mas dizem que apenas um herói preparado consegue a empunhar;
  Portanto, não desista, destinado herói!"""
  end
  def earth_story
    puts """A terra. Após sofrer de um fenômeno misterioso global, monstros da imaginação popular da antiga população ganharam forma
e inclusive poderes. Sem nenhuma forma de se opor à esse poder, na beira do colapso da humanidade, items da imaginação popular ganharam
forma; e, portanto, foram criados items para se opor à esses monstros. Entretanto, esses items haviam uma restrição: apenas um 'herói'
poderia utilizar os items mais fortes com eficácia total, e os outros apenas por humanos com uma alta força vital. Dessa forma, a humanidade
evocaram um 'herói', e o mesmo deve manejar o item mais poderoso criado: a relíquia!; item dito capaz de retornar o mundo à normalidade."""
  end
  def underworld_story
    puts """O mundo original... Ano XXXX; a ciência evoluiu a tal ponto que a humanidade se tornou capaz de alterar as leis da natureza com
extrema facilidade. Contudo, as vidas biológicas sofreram mutações drásticas com essas alterações, de forma que os humanos foram rapidamente
dizimados. Estimula-se que pelo menos 99.9999% foram dizimadas de aproximadamente 30 bilhões de pessoas existentes na época em que a humanidade
adquiriu essa manipulação, e o restante da população vive isolada devido às criaturas em terra que as perseguem até a morte uma vez vistas...
Será que existe alguma salvação?"""
  end
  def normal_ending
    puts 'A relíquia! Com os poderes inatos do herói, os poderes desconhecidos da mesma são liberados, e o mundo retorna a paz.'
  end
  def bad_ending_1
    puts """O herói foi derrotado... 1000 anos se passaram, e o mundo se tornou um completo caos, no qual o rei demônio conseguiu poder 
o suficiente para destruir a relíquia e inclusive viajar entre espaços temporais; contudo, não há nenhuma maneira de o derrotar....
 ______   ______            ______      ______              ______   ______                                           
|        |      | | \\  / | |           |      |  \\      /  |        |      |
|   ___  |______| |  \\/  | |______     |      |   \\    /   |______  |______|
|      | |      | |      | |           |      |    \\  /    |        |    \\
|______| |      | |      | |______     |______|     \\/     |______  |     \\"""
  end
  def bad_ending_2
    puts """O herói foi derrotado... Contudo, 'a organização' estava vigiando seus movimentos, e utiliza de sua existência para criar
  um ser muito mais poderoso que o Rei Demônio. Baseado em mitologias do passado, a organização lhe chama de Satã, e seu poder é capaz
  de cumprir os objetivos que 'a organização' não conseguiu durante todo o seu tempo de existência: alterar a vida original da Terra!
  Logo, o verdadeiro apocalipse começa..."""  
  end
  def special_ending_1
    puts """A relíquia! Com os poderes inatos do herói, os poderes desconhecidos da mesma são liberados, e o mundo retorna a paz. Contudo
  Como a maioria dos monstros foram derrotados e todos os items desse mundo foram adquiridos, então o herói volta para seu mundo original."""
  end
  def special_ending_2
    puts """A relíquia! Com os poderes inatos do herói, os poderes desconhecidos da mesma são liberados, e o mundo retorna a paz. Contudo
    Como o herói foi para o outro mundo, ele foi considerado como um monstro; contudo, por ter muito poder, continuou vivo."""
  end
  def secret_ending_1
    puts """Após o herói ser derrotado pelo Rei Demônio, perto de levar um golpe fatal, o Rei Demônio percebe que o herói carrega documentos peculiares
  Nesse momento, as memórias do Rei Demônio começam a ficar confusas; de um lado, sente a necessidade de destruir a última esperança da humanidade; de outro lado,
  sente que necessita deixar o herói viver. O herói, percebendo isso, ignorou o Rei Demônio e foi adquirir a relíquia. Contudo, o Rei Demônio volta à ofensiva, e
  ambos derramam seus sangues na relíquia, o que despertou uma funcionalidade oculta: as existências de ambos voltam no tempo, para o ano de 2000 da antiga Terra
  com seus corpos originais. Nesse contexto, descobre-se que o Rei Demônio era o primeiro humano à conseguir usar os items e o mesmo que fez todos os relatórios.
  Logo, ambos conhecendo os segredos da Terra do futuro, almejam destruir 'a organização' quando ainda possível; e, pois, salvar o mundo."""
  end
  def secret_ending_2
    puts """Após o herói derrotar o Rei Demônio, antes de dar o golpe fatal no mesmo, lembra-se das atrocidades e dos monstros do outro mundo.
  Nesse sentido, tenta utilizar das magias que aprendeu nos gremórios do outro mundo, e descobre que o Rei Demônio era um humano no passado.
  Dessa forma, como supostamente a relíquia seria um artefato que iria 'expurgar' o mal do mundo, o herói utiliza dos poderes das espadas e magias
  adquiridas na jornada; e, pois, a relíquia libera uma extrema energia, na qual o herói absorve e se torna um ser capaz de viajar entre os espaços temporais.
  Portanto, visando salvar todo o mundo sem que haja sacríficios, viaja no tempo para impedir que 'a organização' se forme, de forma que não
  seja necessário derramar sangue caso a mesma seja criada."""
  end
end
def mapa(dimensao = 6)
  base_do_mapa = []
  for coluna in dimensao.downto(-dimensao)
    ml = [] #matriz linha
    for linha in ((-dimensao)..dimensao)
      ml.append([linha, coluna])
    end
    base_do_mapa.append(ml)
  end
  base_do_mapa #return
end
def map_att
  attributes = ['items', 'enemy', 'nothing', 'ex_dungeon']
  graph = mapa #(dim = 6)
  e_count = 0; n_count = 0; i_count = 0
  true_map = {}
  for line in graph
    for coordinate in line
      if coordinate == [0, 0]
        true_map[coordinate] = 'start'
        next
      end
      true_map[coordinate] = attributes.sample
      if true_map[coordinate] == 'enemy'
        e_count += 1
        attributes.delete('enemy') if e_count == 122 # - 3 cause floor#$enemy_n
      elsif true_map[coordinate] == 'items'
        i_count +=1 
        attributes.delete('items') if i_count == 16 #$i_p
      elsif true_map[coordinate] == 'nothing'
        n_count += 1
        attributes.delete('nothing') if n_count == 29 #hell29!!! # +3 cause enemy #$nothing_p
      elsif true_map[coordinate] == 'ex_dungeon'
        attributes.delete('ex_dungeon')
      end
    end               
  end
  true_map
end
def enemies_and_items_from_earth
  m_used = Hash.new(0)
  e_count_two = 0
  i_count_two = 0
  e_a_i = map_att
  defined_map = {}
  earth_m = $monsters_hash[:earth_monsters].clone
  earth_i = $items_hash[:earth_hash].clone
  e_a_i.each do |coord, att|
    if att == 'enemy'
      att = earth_m.keys.sample
      m_used[att] += 1
      e_count_two += 1
      defined_map[coord] = att
      earth_m.delete(att) if m_used[att] == earth_m[att][:quantity]
    elsif att == 'items'
      att = earth_i.keys.sample
      m_used[att] += 1
      i_count_two += 1
      defined_map[coord] = att
      earth_i.delete(att) if m_used[att] == earth_i[att]
    else
      defined_map[coord] = att
    end
  end
  defined_map
end
def enemies_and_items_from_underworld
  m_used = Hash.new(0)
  e_count_two = 0
  i_count_two = 0
  e_a_i = map_att
  defined_map = {}
  underworld_m = $monsters_hash[:underworld_monsters].clone
  underworld_i = $items_hash[:underworld_hash].clone
  e_a_i.each do |coord, att|
    if att == 'enemy'
      att = underworld_m.keys.sample
      m_used[att] += 1
      e_count_two += 1
      defined_map[coord] = att
      underworld_m.delete(att) if m_used[att] == underworld_m[att][:quantity]
    elsif att == 'items'
      att = underworld_i.keys.sample
      m_used[att] += 1
      i_count_two += 1
      defined_map[coord] = att
      underworld_i.delete(att) if m_used[att] == underworld_i[att]
    else
      defined_map[coord] = att
    end
  end
  defined_map
end
def level(xp)
  if $player_hash[:hero][:xp][:total_xp]/$player_hash[:hero][:lv] >= 15
    until xp < 15 do
      if $player_hash[:hero][:lv] >= 11
        $player_hash[:hero][:xp][:current_xp] = 0
        $player_hash[:hero][:xp][:total_xp] = 150
        puts "Você está no level máximo!"
        return
      end
      $player_hash[:hero][:lv] += 1
      xp -= 15; $player_hash[:hero][:xp][:current_xp] -= 15
      puts "Você subiu um level! Status serão reajustados."
      $player_hash[:hero][:atk] = ($atk_one += 10)..($atk_two += 10)
      $player_hash[:hero][:hp] = ($hp_one += 10)..($hp_two += 10)
      $player_hash[:hero][:spd] += 1
      Item.new(nil).append_stats
    end
  end
end
def earth_battle(villain)
  turn_count = 1
  ph = $player_hash[:hero] #Hash com atk e hp e xp do heroi
  ph_hp = rand(ph[:hp]); ph_hp_tot = ph_hp
  if villain != :mao
    puts "A wild #{villain} has appeared!"
  elsif villain == :mao
    puts """Você encontrou o local onde a relíquia reside; contudo, o rei demônio aparece!
Hohoho, estás se aproximando de mim? O supremo rei demônio? Saiba que você nunca conseguirá me derrotar
e adquirir a relíquia, tolo humano!"""
  end
  eh = $monsters_hash[:earth_monsters][villain] 
  eh_hp = rand(eh[:hp]); eh_hp_tot = eh_hp
  while true
    puts "Turno #{turn_count}: "
    if turn_count % 2 == 1 
      puts "Turno do herói"
      print 'ATACAR ', '|', ' STATUS', "\n", '-'*15, "\n", 'PULAR  ', '|', ' CORRER', "\n"
      action = gets.chomp.strip.upcase
      case action
      when 'ATACAR'  
        eh_hp -= (ph_atk = rand(ph[:atk]))
        puts "Você deu #{ph_atk} de dano no inimigo"
        turn_count += 1
      when 'STATUS'
        puts "Hero's HP: #{ph_hp}/#{ph_hp_tot}"
        puts "Enemy's HP: #{eh_hp}/#{eh_hp_tot}"
      when 'PULAR'
        puts "Turno pulado!"
        turn_count += 1
      when 'CORRER'
        if (Item.new(nil).show_inv).include?(:speed_boots)
          puts 'Você consegue correr do inimigo com facilidade!'
          break
        end
        gamble = rand
        if gamble <= 0.15
          puts 'Você tentou correr, mas falhou. Um turno será gasto...'
          turn_count += 1
          next
        elsif gamble > 0.15
          puts 'Você consegue correr utilizando todas suas forças!'
          break
        end
      else 
        puts "Comando Inválido! Tente novamente."
      end
    elsif turn_count % 2 == 0 
      puts "Turno do inimigo"
      ph_hp -= (eh_atk = rand(eh[:atk]))
      puts "Demon Lord: DARKNESS TOTAL DESPAIR!" if villain == :mao
      puts "O inimigo deu #{eh_atk} de dano no herói!"
      turn_count += 1
    end
    if eh_hp <= 0
      puts "Você derrotou o inimigo!"
      if $player_hash[:hero][:lv] < 11
        puts "Você ganhou #{eh[:xp]} de XP"
        ph[:xp][:current_xp] += eh[:xp] 
        ph[:xp][:total_xp] += eh[:xp] 
        level(ph[:xp][:current_xp])
      end
      if villain == :slime
        break
      else
        return true 
      end
    elsif ph_hp <= 0 
      Texto.new.bad_ending_1
      exit(0)
    end
  end
end
def underworld_battle(villain)
  ph = $player_hash[:hero] #Hash com atk e hp e xp do heroi
  ph_hp = rand(ph[:hp]); ph_hp_tot = ph_hp; ph_magic = ph[:magic]
  if $player_hash[:hero][:spd] >= $monsters_hash[:underworld_monsters][villain][:spd]
    player_turn = true
  elsif $player_hash[:hero][:spd] < $monsters_hash[:underworld_monsters][villain][:spd]
    player_turn = false
  end
  if villain != :the_organization
    puts "A wild #{villain} has appeared!"
  elsif villain == :the_organization
    puts """What is this..."""
  end
  eh = $monsters_hash[:underworld_monsters][villain] 
  eh_hp = rand(eh[:hp]); eh_hp_tot = eh_hp
  while true
    if player_turn == true 
      puts "Turno do herói"
      print 'ATACAR ', '|', ' STATUS', "\n", '-'*15, "\n", 'PULAR  ', '|', ' ...', "\n"
      action = gets.chomp.strip.upcase
      case action
      when 'ATACAR' 
        print 'NORMAL ', '|', ' MAGIA', "\n"
        which_one = gets.chomp.strip.upcase
        if which_one == 'NORMAL'
          eh_hp -= (ph_atk = rand(ph[:atk]))
          puts "Você deu #{ph_atk} de dano no inimigo"
        elsif which_one == 'MAGIA'
          while true
            puts 'AGUA | VENTO | FOGO | TERRA'
            magic_choose = (gets.chomp.strip).upcase
            if magic_choose == 'AGUA'
              if $true_inventory.include?(ph_magic[:water_gremory])
                eh_hp -= ph_magic[:water_gremory]
                puts "Você deu #{ph_magic[:water_gremory]} de dano no inimigo"
              else
                puts 'Você não possui o gremório para essa magia... Você perdeu o turno'
              end
            elsif magic_choose == 'VENTO'
              if $true_inventory.include?(ph_magic[:wind_gremory])
                eh_hp -= ph_magic[:wind_gremory]
                puts "Você deu #{ph_magic[:wind_gremory]} de dano no inimigo"
              else
                puts 'Você não possui o gremório para essa magia... Você perdeu o turno'
              end
            elsif magic_choose == 'FOGO'
              if $true_inventory.include?(ph_magic[:fire_gremory])
                eh_hp -= ph_magic[:fire_gremory]
                puts "Você deu #{ph_magic[:fire_gremory]} de dano no inimigo"
              else
                puts 'Você não possui o gremório para essa magia... Você perdeu o turno'
              end
            elsif magic_choose == 'TERRA'
              if $true_inventory.include?(ph_magic[:earth_gremory])
                eh_hp -= ph_magic[:earth_gremory]
                puts "Você deu #{ph_magic[:earth_gremory]} de dano no inimigo"
              else
                puts 'Você não possui o gremório para essa magia... Você perdeu o turno'
              end
            else 
              puts 'Magia Inválida. Você perdeu o turno'
            end
            break
          end
        else
          puts "Comando Inválido! Tente novamente."
        end
        player_turn = false
      when 'STATUS'
        puts "Hero's HP: #{ph_hp}/#{ph_hp_tot}"
        puts "Enemy's HP: #{eh_hp}/#{eh_hp_tot}"
      when 'PULAR'
        puts "Turno pulado!"
        player_turn = false
      when '...'
        puts '...'
      else 
        puts "Comando Inválido! Tente novamente."
      end
    elsif player_turn == false 
      puts "Turno do inimigo"
      ph_hp -= (eh_atk = rand(eh[:atk]))
      puts "O inimigo deu #{eh_atk} de dano no herói!"
      if villain == :the_organization
        gamble = rand
        if gamble <= 0.08
          puts 'O oponente pega um extra turno!'
          next
        end
      end
      player_turn = true
    end
    if eh_hp <= 0
      puts "Você derrotou o inimigo!"
      if $player_hash[:hero][:lv] < 11
        puts "Você ganhou #{eh[:xp]} de XP"
        ph[:xp][:current_xp] += eh[:xp] 
        ph[:xp][:total_xp] += eh[:xp] 
        level(ph[:xp][:current_xp])
      end
      return true 
    elsif ph_hp <= 0
      if $true_inventory.include?(:phoenix_feather)
        puts "A pena da fénix regenerou seu corpo para antes da batalha; contudo, se esvaiu completamente após..."
        Item.new(:phoenix_feather).delete_from_inv
        break
      end
      Texto.new.bad_ending_2
      exit(0)
    end
  end
end
def the_game_is_on
  x = 0; y = 0
  underworld_key = false
  game_map = enemies_and_items_from_earth
  while true
    puts 'Escolha a posição ([C]ima/[B]aixo/[D]ireita/[E]squerda)'
    direction = (gets.chomp.strip).upcase
    case direction
    when 'C' then game_map[[x, y += 1]]
    when 'B' then game_map[[x, y -= 1]]
    when 'D' then game_map[[x += 1, y]]
    when 'E' then game_map[[x -= 1, y]]
    when 'M' then puts game_map
    when 'Y' then print "x = #{x}" , "\n", "y = #{y}", "\n"
    when 'X' then exit(1) 
    when 'H' then Texto.new.earth_story
    #when 'COUNT' then puts game_map.group_by(&:last).map { |v, a| [v, a.count] }.to_h
    #when 'SPECIAL HASH' then print $monsters_hash
    #when 'SPECIAL HASH 2' then print $player_hash
    #when 'SPECIAL HASH 3' then print $items_hash[:earth_hash]
    #when 'I' then print Item.new(nil).show_inv, "\n"
    #when 'S' then puts "ATK = #{$player_hash[:hero][:atk]}; HP = #{$player_hash[:hero][:hp]}"
    end 
    if direction == 'C' || direction == 'B' || direction == 'D' || direction == 'E'
      if $items_hash[:earth_hash].has_key?(game_map[[x, y]]) 
        puts 'Você encontrou um item. Adicionando-o ao inventário e o equipando caso seja um item equipável...'
        if game_map[[x, y]] != :doc
          Item.new(game_map[[x,y]]).add_to_inv
          Item.new(game_map[[x, y]]).append_stats
        elsif game_map[[x, y]] == :doc
          Item.new(game_map[[x, y]]).earth_items
        end
        game_map[[x, y]] = 'nothing'
      elsif $monsters_hash[:earth_monsters].has_key?(game_map[[x, y]])
        results = earth_battle(game_map[[x, y]])
        if results == true && game_map[[x, y]] == :mao
          #earth_counters = game_map.group_by(&:last).map { |base, quantos| [base, quantos.count] }.to_h
          #underworld_counters = Hash.new(0)
          #if underworld_key == true
          #  underworld_counters = underworld_map.group_by(&:last).map { |base_2, quantos_2| [base, quantos_2.count] }.to_h
          #end
          #if earth_counters[:nothing] == 133 && underworld_counters[:nothing] == 157 
          #  Texto.new.secret_ending_2
          #elsif earth_counters[:nothing] == 133 && underworld_key == false
          #  Texto.new.special_ending_1
          #else
          Texto.new.normal_ending
          exit(0)
        elsif results == true && game_map[[x, y]] != :mao
          game_map[[x, y]] = 'nothing'
        end
      elsif game_map[[x, y]] == 'nothing'
        puts "Não tem nada aqui"
      elsif game_map[[x, y]] == 'start'
        game_map[[x, y]] = 'nothing'
      elsif game_map[[x, y]] == 'ex_dungeon'
        if (Item.new(nil).show_inv).include?(:demon_sword) && (Item.new(nil).show_inv).include?(:demon_armor) && ($player_hash[:hero][:xp][:total_xp] > 60)
          puts "Welcome... to the place u shouldn't ever try to enter!"
          if underworld_key == false
            underworld_map = enemies_and_items_from_underworld
            underworld_key = true
          end
          while true
            puts 'Escolha a posição ([C]ima/[B]aixo/[D]ireita/[E]squerda)'
            direction = (gets.chomp.strip).upcase
            case direction
            when 'C' then underworld_map[[x, y += 1]]
            when 'B' then underworld_map[[x, y -= 1]]
            when 'D' then underworld_map[[x += 1, y]]
            when 'E' then underworld_map[[x -= 1, y]]
            when 'H' then Texto.new.underworld_story
            when 'U' then puts underworld_map
            when 'M' then puts game_map
            when 'COUNT' then puts underworld_map.group_by(&:last).map { |base, quantos| [base, quantos.count] }.to_h
            end
            if direction == 'C' || direction == 'B' || direction == 'D' || direction == 'E'
              if $items_hash[:underworld_hash].has_key?(underworld_map[[x, y]]) 
                puts 'Você encontrou um item. Adicionando-o ao inventário e o equipando caso seja um item equipável...'
                if underworld_map[[x, y]] != :doc
                  Item.new(underworld_map[[x,y]]).add_to_inv
                  Item.new(underworld_map[[x, y]]).underworld_items
                elsif game_map[[x, y]] == :doc
                  Item.new(underworld_map[[x, y]]).underworld_items
                end
              elsif $monsters_hash[:underworld_monsters].has_key?(underworld_map[[x, y]])
                results = underworld_battle(underworld_map[[x, y]])
                if results == true && underworld_map[[x, y]] == :the_organization
                  puts '. . .'
                elsif results == true && underworld_map[[x, y]] != :the_organization
                  underworld_map[[x, y]] = 'nothing'
                end
              elsif underworld_map[[x, y]] == 'nothing'
                puts "Não tem nada aqui"
              elsif underworld_map[[x, y]] == 'start'
                underworld_map[[x, y]] = 'nothing'
              elsif underworld_map[[x, y]] == 'ex_dungeon'
                puts "Retornando ao mundo original..."
                break
              elsif underworld_map[[x, y]].nil?
                puts "Herói, você está indo além do onde meus poderes indicaram onde a relíquia está. Retorne a um escopo válido"
                if x > 6
                  x -= 1
                elsif x < -6
                  x += 1
                elsif y > 6
                  y -= 1
                elsif y < -6
                  y += 1
                end
                puts "Retornando ao escopo anterior."
                puts "... ... ..."
              end
            end
          end
        else
          puts 'Você não está pronto... Retorne quando tiveres o suficiente para aguentar o verdadeiro mundo...'
        end
      elsif game_map[[x, y]].nil?
        puts "Herói, você está indo além do onde meus poderes indicaram onde a relíquia está. Retorne a um escopo válido"
        if x > 6
          x -= 1
        elsif x < -6
          x += 1
        elsif y > 6
          y -= 1
        elsif y < -6
          y += 1
        end
        puts "Retornando ao escopo anterior."
        puts "... ... ..."
      end
    end
  end
end
while true
  puts "Bem-vindo ao Reru Story!"
  puts "[1] Iniciar Jogo", "[2] Tutorial", "[3] Sair do Jogo" #,"[4] "
  menu_start = gets.chomp.strip
  case menu_start
  when '1' then the_game_is_on
  when '2' then Texto.new.tutorial
  when '3' then exit(0)
  end
end