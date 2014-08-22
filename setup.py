from setuptools import setup

setup(
	name='balabas',
	version='0.0.1',
	url='https://localhost:8080',
	license='MIT',
	author='Anton Nesterov',
	author_email='nesforge@gmail.com',
	description='balabas',
	long_description=__doc__,
	packages=['balabas'],
	zip_safe=False,
	platforms='any',
	install_requires=[
		'Flask',
	]
)

