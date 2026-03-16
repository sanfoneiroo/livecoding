```python
import board
import digitalio
import time
import usb_midi
import adafruit_midi
import analogio

from adafruit_midi.note_on import NoteOn
from adafruit_midi.note_off import NoteOff
from adafruit_midi.control_change import ControlChange

# ------------------------------------------------
# CONFIGURAÇÃO DA PLACA
# ------------------------------------------------
# Escolha qual placa está sendo utilizada
#
# RP2040 ZERO  -> LED RGB (WS2812) no pino GP16
# RASPBERRY PI PICO -> LED onboard simples no pino GP25
#
# Defina uma das opções como True

USE_RP2040_ZERO = True
USE_PICO = False

# ------------------------------------------------
# LED DE FEEDBACK
# ------------------------------------------------

if USE_RP2040_ZERO:

    import neopixel

    pixel = neopixel.NeoPixel(board.GP16, 1)
    pixel.fill((0,0,0))

    def led_off():
        pixel.fill((0,0,0))

    def led_green():
        pixel.fill((0,255,0))

    def led_blue():
        pixel.fill((0,0,255))

    def led_red():
        pixel.fill((255,0,0))


elif USE_PICO:

    led = digitalio.DigitalInOut(board.GP25)
    led.direction = digitalio.Direction.OUTPUT

    def led_off():
        led.value = False

    def led_green():
        led.value = True

    def led_blue():
        led.value = True

    def led_red():
        led.value = True


# ------------------------------------------------
# MIDI
# ------------------------------------------------

midi = adafruit_midi.MIDI(
    midi_out=usb_midi.ports[1],
    out_channel=0
)

NOTE1 = 60
NOTE2 = 62
NOTE3 = 64

CC_NUMBER = 1   # modulation wheel


# ------------------------------------------------
# BOTÕES
# ------------------------------------------------

button1 = digitalio.DigitalInOut(board.GP1)
button1.direction = digitalio.Direction.INPUT
button1.pull = digitalio.Pull.UP

button2 = digitalio.DigitalInOut(board.GP2)
button2.direction = digitalio.Direction.INPUT
button2.pull = digitalio.Pull.UP

button3 = digitalio.DigitalInOut(board.GP3)
button3.direction = digitalio.Direction.INPUT
button3.pull = digitalio.Pull.UP


# ------------------------------------------------
# POTENCIÔMETRO
# ------------------------------------------------

pot = analogio.AnalogIn(board.GP26)


# ------------------------------------------------
# ESTADO
# ------------------------------------------------

last_state1 = True
last_state2 = True
last_state3 = True

last_cc = -1

print("Sistema iniciado - MIDI Controller")


# ------------------------------------------------
# LOOP PRINCIPAL
# ------------------------------------------------

while True:

    # -------------------------
    # BOTÃO 1
    # -------------------------

    state1 = button1.value

    if state1 != last_state1:

        if not state1:

            print("BOTAO1 -> NoteOn")
            led_green()
            midi.send(NoteOn(NOTE1, 120))

        else:

            print("BOTAO1 -> NoteOff")
            led_off()
            midi.send(NoteOff(NOTE1, 0))

    last_state1 = state1


    # -------------------------
    # BOTÃO 2
    # -------------------------

    state2 = button2.value

    if state2 != last_state2:

        if not state2:

            print("BOTAO2 -> NoteOn")
            led_blue()
            midi.send(NoteOn(NOTE2, 120))

        else:

            print("BOTAO2 -> NoteOff")
            led_off()
            midi.send(NoteOff(NOTE2, 0))

    last_state2 = state2


    # -------------------------
    # BOTÃO 3
    # -------------------------

    state3 = button3.value

    if state3 != last_state3:

        if not state3:

            print("BOTAO3 -> NoteOn")
            led_red()
            midi.send(NoteOn(NOTE3, 120))

        else:

            print("BOTAO3 -> NoteOff")
            led_off()
            midi.send(NoteOff(NOTE3, 0))

    last_state3 = state3


    # -------------------------
    # POTENCIÔMETRO
    # -------------------------

    pot_value = pot.value           # 0–65535
    cc_value = pot_value >> 9       # converte para 0–127

    if abs(cc_value - last_cc) > 1:

        midi.send(ControlChange(CC_NUMBER, cc_value))

        print("CC:", cc_value)

        last_cc = cc_value


    time.sleep(0.01)

# fim

```
