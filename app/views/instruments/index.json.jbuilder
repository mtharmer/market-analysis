# frozen_string_literal: true

json.array! @instruments, partial: 'instruments/instrument', as: :instrument
