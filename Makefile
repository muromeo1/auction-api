all: rubocop reek rspec

rubocop:
	@ echo '|---------------|'
	@ echo '|--- Rubocop ---|'
	@ echo '|---------------|'
	@ echo ''
	@ bundle exec rubocop
reek:
	@ echo ''
	@ echo '|---------------|'
	@ echo '|---- Reek -----|'
	@ echo '|---------------|'
	@ echo ''
	@ bundle exec reek
rspec:
	@ echo ''
	@ echo '|---------------|'
	@ echo '|---- Rspec ----|'
	@ echo '|---------------|'
	@ echo ''
	@ bundle exec rspec
