require 'socket'

KNOWN_GOOD = 9000
KNOWN_BAD = 10000

def datagram_works(size)
  sock = UDPSocket.new
  sock.connect('localhost', 9001)
  begin
    sock.send('a' * size, 0)
  rescue Errno::EMSGSIZE => e
    return false
  end
  return true
end

def bisect(lower, upper)
  test_val = (lower + upper) / 2
  if test_val == lower || test_val == upper
    puts 'done'
    return
  end
  puts "trying #{test_val}"
  if datagram_works(test_val)
    puts 'GOOD!'
    return bisect(test_val, upper)
  else
    puts 'BAD!'
    return bisect(lower, test_val)
  end
end

bisect(KNOWN_GOOD, KNOWN_BAD)
