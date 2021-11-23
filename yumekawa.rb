
class Yumekawa
    attr :memory
    attr :pointer
    attr :loop_memory
    attr :loop_pointer
    attr :skip_count
    attr :char_dict
    attr :output
    attr :iterator
    def initialize
        @memory = Array.new(256, 0)
        @pointer = 0
        @loop_memory = Array.new(20, 0)
        @loop_pointer = 0
        @skip_count = 0
        @iterator = 0
        @output = ''
        initializeCharDict
    end
    def initializeCharDict
        @char_dict = [
            '',
            # 1
            'あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 
            'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と',
            'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'へ', 'ほ',
            'ま', 'み', 'む', 'め', 'も', 'や', '', 'ゆ', '','よ',
            'ら', 'り', 'る', 'れ', 'ろ', 'わ', '', 'を', '', 'ん',
            # 'が', 'ぎ', 'ぐ', 'げ', 'ご', 'ざ', 'じ', 'ず', 'ぜ', 'ぞ', 'だ', 'ぢ', 'づ', 'で', 'ど', 'ば', 'び', 'ぶ', 'べ', 'ぼ',

            # 51
            'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ', #55

            #56
            'ぁ', 'ぃ', 'ぅ', 'ぇ', 'ぉ', 'ゃ', 'ゅ', 'ょ', 'っ', #64

            #65
            '、', '。', '　', "\n", #67
        ]
    end

    def exec(source)
        # puts 'ゆめかわじっこう'
        # puts 'そーす：' + source
        @iterator = 0
        while @iterator < source.length
            step(source.split('')[@iterator])
            @iterator += 1
        end
    end
    def step(char)
    if @skip_count > 0
        if char === 'ぁ'
            @skip_count += 1
        elsif char === 'っ'
            @skip_count -= 1
        end
        return
    end
        case char
        when 'ゆ'
            incrementMemory
        when 'め'
            output
        when 'か'
            incrementPointer
        when 'わ'
            decrementMemory
        when 'ふ'
            decrementPointer
        when 'ぁ'
            startLoop
        when 'っ'
            endLoop
        when 'き'
        when 'ゅ'
            incrementMemory
        end
    end
    def incrementMemory
        @memory[@pointer] += 1
    end
    def decrementMemory
        @memory[@pointer] -= 1
    end
    def incrementPointer
        @pointer += 1
    end
    def decrementPointer
        @pointer -= 1
    end
    def startLoop
        if @memory[@pointer] === 0
            @skip_count += 1
        else
            @loop_memory[@loop_pointer] = @iterator
            @loop_pointer += 1
        end
    end
    def endLoop
        if @memory[@pointer] === 0
            @loop_pointer = @loop_pointer - 1
        else
            @iterator = @loop_memory[@loop_pointer - 1]
        end
    end
    def output
        print decode
    end
    def decode
        if @pointer > @char_dict.length
            return ''
        else
            return @char_dict[@memory[@pointer]]
        end
    end
end

class YumekawaCLI
    attr_reader :yumekawa
    def initialize
        @yumekawa = Yumekawa.new
    end
    def hello
        puts 'ゆめかわぁるどへようこそ♡'
    end
    def run
        puts 'はしるのつらい。'
        file = ARGV[1]
        source = File.read(file)
        @yumekawa.exec(source)
    end
    def input
        puts 'いんぷっともおど。ゆめかわふぁっきゅのぷろぐらむをにゅうりょくしてね。'
        puts 'まだじっそうされてないよ'
        source = gets.chomp
        # @yumekawa.exec(source)
    end
end

yumekawaCLI = YumekawaCLI.new

# swith by ARGV[0]
case ARGV[0]
when 'hello'
    yumekawaCLI.hello
when 'run'
    # if you dont input ARGV[1], then show error message
    if not ARGV[1]
        puts 'だいにひきすうとしてふぁいるぱすをにゅうりょくしてね'
        # exit
    else
        yumekawaCLI.run
    end
when 'input'
    yumekawaCLI.input
end